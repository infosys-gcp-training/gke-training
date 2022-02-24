# GKE Training Module
## Activity 04 - Pods

# Activity Objective

The purpose of this activity is to learn about Kubernetes **Pods**. By the time you are finished with this activity, you will have a better idea of **pods**. How to deploy them, how they differ from each other. How to list them and how to view their details.

## Create a cluster
If you haven't already, just refer here.
[Create a cluster](01-gke-cluster/INSTRUCTIONS.md)

Once connected, you use the kubectl command to list, view, create, update, delete resources

## Using kubectl commands

Let's check that we are connected.

#### View nodes
```
$ kubectl get nodes
```
> You should see 3 nodes.

Let's create a pod
#### Create a pod with a nginx image
```
$ kubectl run nginx-pod –image nginx
```

#### Verify that it was created successfully
```
$ kubectl get pods
```
> You should be able to see the pod with the name **nginx-pod**

#### Create a second pod with a nginx image
```
$ kubectl run nginx-pod-2 –image nginx
```

#### Verify that it was created successfully
```
$ kubectl get pods
```
> You should be able to see the **nginx-pod** and the **nginx-pod-2** pods


#### View the pods with their ip addresses and the node they are scheduled on.
```
$ kubectl get pods –output wide
```
*or*
```
$ kubectl get po -o wide  ← short form
```

#### Check more details about the _nginx-pod_ pod
```
$ kubectl describe pod nginx-pod
```

> Note **nginx-pod**’s ip address \
Will be referred to as [nginx-pod_IP_ADDRESS] in the next step*

#### Connect to nginx-2 pod and CURL nginx-1 pod

```
$ kubectl exec -it nginx-pod-2 – sh
# curl [nginx-pod_IP_ADDRESS]
```
> Output should be the default nginx index.html page.

> We can only access the nginx-pod from within the cluster. We will learn about how to make it accessible external in later lessons with [services](06-services/INSTRUCTIONS.md)

> Let's look at our workloads with the GCP Console UI.

#### View your workloads in the GCP Console
1. Go to Kubernetes Engine
1. Go to Workloads
1. Look at the workloads you created.
1. Click on them and have a look at their details.

### Clean Up
```
$ kubectl delete pod nginx-pod
$ kubectl delete pod nginx-pod-2
```

