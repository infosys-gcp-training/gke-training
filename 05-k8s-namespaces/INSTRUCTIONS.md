# GKE Training Module
## Activity 05 - Namespaces

## Activity Objective
The purpose of this activity is to learn about Kubernetes **Namespaces**. By the time you are finished with this activity, you will have a better idea of **namespaces**. How to use them to organize your workloads and limit access to workloads using **namespaces**.

#### View pods in the default namespace
```
$ kubectl get pods
```
or
```
$ kubectl get po  ← short form
```

#### Create a namespace call **blue**
```
$ kubectl create namespace blue
```
or
```
$ kubectl create ns blue ← short form
```

#### Create a _nginx_ pod in the _blue_ namespace
```
$ kubectl run nginx-blue –-namespace blue
```
or
```
$ kubectl run nginx-blue –ns blue
```

#### View pods in the blue namespace
```
$ kubectl get pods –-namespace blue
```
or
```
$ kubectl get po -n blue ← short form
```

#### Create a _nginx_ pod in the _red_ namespace
```
$ kubectl run nginx-red –-namespace red
```
or
```
$ kubectl run nginx-red –ns red
```
> Oops, need to create the _red_ namespace first

#### Create a namespaces call **red**
```
$ kubectl create namespace red
```
or
```
$ kubectl create ns red ← short form
```

#### Create a _nginx_ pod in the _red_ namespace
```
$ kubectl run nginx-red –-namespace red
```
or
```
$ kubectl run nginx-red –ns red
```

#### View pods in the _red_ namespace
```
$ kubectl get pods –-namespace red
```
or
```
$ kubectl get po -n red ← short form
```

#### Create a namespace call **yellow**
```
$ kubectl create namespace yellow
```
or
```
$ kubectl create ns yellow ← short form
```

#### Create a _nginx_ pod in the _yellow_ namespace
```
$ kubectl run nginx-yellow –-namespace yellow
```
or
```
$ kubectl run nginx-yellow –ns yellow
```

#### View pods in the _yellow_ namespace
```
$ kubectl get pods –-namespace yellow
```
or
```
$ kubectl get po -n yellow ← short form
```
#### View pods in the **yellow** namespace
```
$ kubectl get pods –-namespace yellow
```
or
```
$ kubectl get po -n yellow ← short form
```

## Granting access to a namespace
Your account has access to all the resources on the cluster. We will create a **testuser** and using roles & rolebindings, we will grant access to some of the namespaces.

First let's check our own access. We can use `kubectl auth can-i [COMMAND]`.

#### Check your access.
```
$ kubectl auth can-i get pods
```
> The answer should be “yes”

#### Deploy the testuser related roles
```
$ kubectl apply -f ./testuser 
```

#### Check the testuser's access.
```
$ kubectl auth can-i get pods --as testuser
```
> The answer should be “no”
> The testuser does not have access to the _default_ namespace.

#### Check your access to the pods in the _blue_ namespace
```
$ kubectl auth can-i get pods -n blue
```
> The answer should be “yes”

#### Check the testuser's access to the pods in the _blue_ namespace
```
$ kubectl auth can-i get pods -n blue --as testuser
```
> The answer should be “yes”

#### Check your access to the pods in the _red_ namespace
```
$ kubectl auth can-i get pods -n red
```
> The answer should be “yes”

#### Check the testuser's access to the pods in the _red_ namespace
```
$ kubectl auth can-i get pods -n red --as testuser
```
> The answer should be “no”
The testuser does not have access to the _red_ namespace.
So you can see how namespaces can be used with roles and rolebindings to grant (or indirectly limit) access to resources. 

What happens if you delete a namespace?

#### Delete the **red** namespace
```
$ kubectl delete ns red
```


#### View pods in the **red** namespace
```
$ kubectl get pods –-namespace red
```
or
```
$ kubectl get po -n red ← short form
```
> Note that this doesn't work anymore. The namespace and its resources are gone.
