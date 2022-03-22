# GKE Training Module
## Activity 03 - Deployments
### Part 1

## Activity Objective
The purpose of this activity is to learn about Kubernetes **Deployments**. By the time you are finished with this activity, you will have a better idea of **deployments**. How to deploy them imperatively, how to list them and how to view their details.

## Create a cluster
If you haven't already, just refer here.
[Create a cluster](01-gke-cluster/INSTRUCTIONS.md)

Once connected, you use the **kubectl** command to list, view, create, update, delete resources
_These are **imperative** commands._

## Using kubectl commands

Let's check that we are connected.
#### View nodes
```
$ kubectl get nodes
```
> You should see 3 nodes.

Once connected, you use the kubectl command to list, view, create, update, delete resources

## Using kubectl commands
#### View nodes
```
$ kubectl get nodes
```

#### View nodes
```
$ kubectl get nodes
```
> You should see 3 nodes.

Let's create a deployment with 4 replicas

#### Create a deployment with a nginx image
```
$ kubectl create deployment nginx-dep –image nginx –replicas 4
```

#### Verify that the deployment was created successfully
```
$ kubectl get deployments
```

#### Verify that the pods are all created succesfully
```
$ kubectl get pods
```

Let's scale our deployment to have 10 replicas
#### Scale the deployment up
```
$ kubectl scale deployments nginx-dep --replicas=10
```

#### Observe the deployment scale up
```
$ kubectl get pods
```
See how the pods are being created and deployed.

Let's scale our deployment to have 10 replicas
#### Scale the deployment down
```
$ kubectl scale deployments nginx-dep --replicas=2
```

#### Observe the deployment scale down
```
$ kubectl get pods
```

#### View your workloads in the GCP Console
1. Go to Kubernetes Engine
1. Go to Workloads
1. Look at the workloads you created.
1. Click on them and have a look at their details.

### Clean Up
```
$ kubectl delete deployment nginx-dep
```

## References
* [Kubernetes Deployments](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)
* [Deployments in GKE](https://cloud.google.com/kubernetes-engine/docs/concepts/deployment)
* [Kubernetes **deployment** Command](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#-em-deployment-em-)
