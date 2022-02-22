# GKE Training Module
## Activity 01 - Clusters, Nodes, Pods & Deployments

# Activity Objective

The purpose of this activity is to learn about Kubernetes Clusters, Pods and Deployments. By the time you are finished with this activity, you will have a better idea of Pods & Deployments. How to deploy them, how they differ from each other. How to list them and how to view their details.

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

Once connected, you use the kubectl command to list, view, create, update, delete resources

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

#### View deployments
```
$ kubectl get deployment
```
*or*
```
$ kubectl get deploy  ← short form
```

#### Create a pod with a nginx image
```
$ kubectl run [NAME] –image nginx
```

Ex: `$ kubectl run nginx-1 –image nginx`

#### Verify that it was created successfully
```
$ kubectl get pods
```

#### Create a second pod with a nginx image
```
$ kubectl run nginx-2 –image nginx
```

#### Verify that it was created successfully
```
$ kubectl get pods
```

#### View the pods with their ip addresses and relevant node
```
$ kubectl get pods –output wide
```
*or*
```
$ kubectl get po -o wide  ← short form
```

#### Check more details about the nginx-1 pod
```
$ kubectl describe pod nginx-1
```

*Note nginx-1’s ip address \
Will be referred to as [nginx-1_IP_ADDRESS] in the next step*

#### Connect to nginx-2 pod and CURL nginx-1 pod

```
$ kubectl exec -it nginx-2 – sh
# curl [nginx-1_IP_ADDRESS]
```

_Output should be the default nginx index.html page._

#### Create a deployment with a nginx image
```
$ kubectl create deployment nginx-dep –image nginx –replicas 4
```

#### Verify that it was created successfully
```
$ kubectl get deployments
$ kubectl get pods
```

#### Scale the deployment up
```
$ kubectl scale deployments nginx-deploy --replicas=10
```

#### Observe the deployment scale up
```
$ kubectl get pods
```

#### Scale the deployment down
```
$ kubectl scale deployments nginx-deploy --replicas=2
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
$ kubectl delete pod nginx-1
$ kubectl delete pod nginx-2
$ kubectl delete deployment nginx-dep
```

## Useful Links

#### Kubernetes Commands Cheat Sheet
  https://kubernetes.io/docs/reference/kubectl/cheatsheet/

#### Google Courses Qwiklabs Quest for Kubernetes
  https://googlecourses.qwiklabs.com/quests/29

#### Udemy Beginner Course on Kubernetes
  https://www.udemy.com/course/learn-kubernetes/

#### Certified Kubernetes Administrator (CKA) course with Practice Tests
  https://www.udemy.com/course/certified-kubernetes-administrator-with-practice-tests/

#### Kubernetes Certified Application Developer (CKAD) course with Tests
https://www.udemy.com/course/certified-kubernetes-application-developer/

#### Learning Docker
https://www.udemy.com/course/learn-docker/

#### Understanding how CIDR ranges work with Nodes, Pods and Services
https://cloud.google.com/kubernetes-engine/docs/how-to/flexible-pod-cidr
*Don’t pay the full price, Udemy often (almost weekly) has sales at 90% off. Or you can access in Incognito mode and get the new signup code. You will probably pay ~¥1,300 - ¥2,000 per course.

