# GKE Training Module
## Activity 01 - Clusters
### Part 1

## Activity Objective

The purpose of this activity is to learn about creating a GKE Kubernetes Clusters and how to connect to it.

## Create your own cluster
1. Create a new project or open an existing project.
1. Go to Kubernetes Engine
1. Click **CREATE**
1. Click **CONFIGURE** beside the GKE Standard option
1. Click **USE A SETUP GUIDE** and **My First Cluster** for a walkthrough or just click **CREATE**
*Wait for it to finished creating*

## Connect to your cluster
1. Click on the cluster
1. Click **CONNECT**
1. Click **RUN IN CLOUD SHELL**
1. The Cloud Shell terminal will open, press “Enter” in the Cloud Shell

You can also choose to copy the gcloud command. Save the command for whenever you wish to connect to the cluster, you can just reuse the command. \
Ex: `gcloud container clusters get-credentials [CLUSTER_NAME] --zone [CLUSTER_ZONE] --project [PROJECT_ID]`

Once connected, you use the **kubectl** command to list, view, create, update, delete resources
> These are **imperative** commands.

## Using kubectl commands
#### View nodes
```
$ kubectl get nodes
```

#### View nodes with ip addresses
```
$ kubectl get nodes –output wide
```
*or*
```
$ kubectl get nodes -o wide  ← short form
```
You should see 3 nodes.


#### View pods
> We have't created any pods yet so you won't see anything.
```
$ kubectl get pods
```
*or*
```
$ kubectl get po  ← short form
```

#### View deployments
> We have't created any deployments yet so you won't see anything.
```
$ kubectl get deployments
```
*or*
```
$ kubectl get deploy  ← short form
```

#### View your cluster in the GCP Console
1. Go to **Kubernetes Engine**
1. Go to **Clusters**
1. Click on the cluster to see more details.

#### View your workloads in the GCP Console
> We haven't deployed any applications or workloads yet, so you won't see anything.
1. Go to **Kubernetes Engine**
1. Go to **Workloads**
1. Click on a workload and have a look at their details.

### Clean Up
> If you are finished, you can delete the cluster. However, if you are going to continue with the other activities, you can keep the cluster and ignore this step.
1. Go to **Kubernetes Engine**
1. Go to **Clusters**
1. Click on the cluster to delete
1. Click **DELETE**
