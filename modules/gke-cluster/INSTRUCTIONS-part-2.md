# GKE Training Module
## Activity 01 - Clusters
### Part 2

## Activity Objective

The purpose of this activity is to learn about creating a specific VPC Network for a VPC-native GKE Kubernetes Clusters. It is good to learn about how to allocate the correct range of IPs in your subnets for a GKE cluster to function properly. You can refer to this link here [IP Address Range Planning](https://cloud.google.com/kubernetes-engine/docs/concepts/alias-ips#defaults_limits).

### Understanding CIDR ranges for Nodes 
For example: If we wanted to created a cluster that could have up to 1000 Nodes. \
What CIDR range would we require? \
10.10.0.0/22

This would give us 1022 Nodes.
How do we calculate that? \
Well, this is the following formula. \
![N = 2^(32 - S) - 4](https://render.githubusercontent.com/render/math?math=N%20=%202^{%2832%20-%20S%29}%20-%204#gh-light-mode-only)
![N = 2^(32 - S) - 4](https://render.githubusercontent.com/render/math?math=\color{white}N%20=%202^{%2832%20-%20S%29}%20-%204#gh-dark-mode-only)

N - Is the number of nodes
S - Is the CIDR range size that you need.
> This can be confusing. For example **/32** is for a single IP address. \
> If you try the value **/22** \
> How many can we handle?

**EX:**
> N = 2^{(32 - 22)} - 4 \
> N = 2^10 - 4 \
> N = 1024 - 4 \
> N = 1020 \

> We need to remove 4 IP addresses because GCP always reserves 4 IPs in each subnet in the primary range.

| Reserved IP address | Description | 
| ------------------- | ----------- |
| Network | First address in the primary IP range for the subnet |
| Default gateway | Second address in the primary IP range for the subnet |
| Second-to-last address | Second-to-last address in the primary IP range for the subnet that is reserved by Google Cloud for potential future use |
| Broadcast | Last address in the primary IP range for the subnet |

We can have a cluster with up to **1020** nodes.
> Or can we...?

### Understanding CIDR ranges for Pod IP
Actually, there is still a second step in calculating our total Node CIDR. It is dependant on our pod CIDR range.

Let's try a CIDR range of /20 for the pods.
> **EX:**
N = 2^{(32 - 20)} \
N = 2^12 \
N = 4096 

This gives us **4096** IP address. But we need to divide by 220.
> **EX:**
4096 / 220 \
18 \
Round down to 2^4 = 16

So actually, with a Pod CIDR range of /20, we only can have up to 16 nodes in our cluster. \
**/17** would probably be a better CIDR range for our pods.

 [Reserved IP addresses in a subnet](https://cloud.google.com/vpc/docs/vpc#reserved_ip_addresses_in_every_subnet)
> You can refer here for more about how to calculate your IP ranges for your cluster - [IP Address Range Planning](https://cloud.google.com/kubernetes-engine/docs/concepts/alias-ips#defaults_limits)

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
* [Create and modify Virtual Private Cloud (VPC) networks](https://cloud.google.com/vpc/docs/create-modify-vpc-networks)
* [IP Address Range Planning](https://cloud.google.com/kubernetes-engine/docs/concepts/alias-ips#defaults_limits)
* [Reserved IP addresses in a subnet](https://cloud.google.com/vpc/docs/vpc#reserved_ip_addresses_in_every_subnet)
* [Understanding IP address management in GKE](https://cloud.google.com/blog/products/containers-kubernetes/ip-address-management-in-gke)
