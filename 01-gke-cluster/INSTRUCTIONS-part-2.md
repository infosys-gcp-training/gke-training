# GKE Training Module
## Activity 01 - Clusters
### Part 2

## Activity Objective

The purpose of this activity is to learn about creating a specific VPC Network for a VPC-native GKE Kubernetes Clusters.


There are 2 ways of doing this:
1. Secondary ranges created and managed by GKE. [GKE Managed](#managed-by-gke)
1. Secondary ranges created and managed by the user (you). [User Managed](#user-managed)


#### Create a VPC network
```
gcloud compute networks create gke-training-net \
    --subnet-mode=custom \
    --bgp-routing-mode=global \
    --mtu=1460
```

#### Verify that the network was created
```
gcloud compute networks describe gke-training
```

#### Create a VPC subnet
```
gcloud compute networks create gke-training-subnet \
    --subnet-mode=custom \
    --bgp-routing-mode=global \
    --mtu=1460
```

### Managed by GKE

With this method, GKE creates the necessary subnet, and secondary 
#### Create the GKE cluster
```
gcloud container clusters create gke-training-cluster-2 \
  --enable-ip-alias \
  --zone=us-central1-a \
  --network=gke-training \
  --create-subnetwork name=gke-training-subnet,range=10.10.0.0/24 \
  --cluster-ipv4-cidr=10.20.0.0/16 \
  --services-ipv4-cidr=10.30.0.0/20
```

### User-managed
#### Create VPC subnet
```
gcloud compute networks subnets create gke-training-subnet \
  --network=gke-training-net \
  --range=10.10.0.0/24 \
  --region=us-central1
```

#### Create the GKE cluster
```
gcloud container clusters create gke-training-cluster \
    --region=us-central1 \
    --enable-ip-alias \
    --subnetwork=gke-training-subnet \
    --cluster-secondary-range-name=gke-pods \
    --services-secondary-range-name=gke-services
```


### Clean Up

#### Delete the Cluster
```
gcloud container clusters delete gke-training-cluster
```

#### Delete the subnet
```
gcloud compute networks subnets delete gke-training-subnet --region=us-central1
```

#### Delete the network
```
gcloud compute networks delete gke-training-net
```

## Links
[IP Address Range Planning](https://cloud.google.com/kubernetes-engine/docs/concepts/alias-ips#defaults_limits)
