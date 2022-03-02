# GKE Training Module
## Activity 05 - Deployments
### Part 2

## Activity Objective

The purpose of this activity is to learn about Kubernetes **Deployments**. By the time you are finished with this activity, you will have a better idea of **deployments** How to deploy them declaratively, how to list them and how to view their details.

## Links
* [Kubernetes Deployments](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)
* [Deployments in GKE](https://cloud.google.com/kubernetes-engine/docs/concepts/deployment)

## Create a cluster
If you haven't already, just refer here.
[Create a cluster](01-gke-cluster/INSTRUCTIONS.md)

Once connected, you use the **kubectl** command to list, view, create, update, delete resources
> These are **imperative** commands.

## Using kubectl commands

Let's check that we are connected.
#### View nodes
```
$ kubectl get nodes
```
> You should see 3 nodes.

#### Inspect the _nginx_ pod YAML file
```
cat ./nginx/nginx-pod.yaml
```

#### Deploy the nginx pod YAML file
We can use the `kubectl apply -f FILENAME` command.
```
kubectl apply -f ./nginx/nginx-pod.yaml
```

#### Inspect the _nginx_ deployment YAML file
```
cat ./nginx/nginx-dep.yaml
```

#### Deploy the nginx deployment YAML file
We can use the `kubectl apply -f FILENAME` command.
```
kubectl apply -f ./nginx/nginx-dep.yaml
```

#### Check that the nginx deployment was deployed
```
kubectl get deployments -o wide
```

#### Inspect the nginx deployment
```
kubectl describe deployment nginx-dep
```

#### Inspect the second version of the _nginx_ deployment YAML file
```
cat ./nginx/nginx-v2-dep.yaml
```
There is a different image and a different number of replicas.

In Linux, you can also use the `diff` command to see the differences in the files.
#### Use the _diff_ command to see the differences
```
diff ./nginx/nginx-dep.yaml ./nginx/nginx-v2-dep.yaml
```

#### Deploy the new version of the nginx deployment
```
kubectl apply -f ./nginx/nginx-v2-dep.yaml
```

#### Check the status of the deployment
```
kubectl rollout status deployment/nginx-dep
```


#### Rollback the nginx deployment
```
kubectl rollout undo deployment/nginx-dep
```

#### View the rollout history of the nginx deployment
```
kubectl rollout history deployment/nginx-deployment --revision=2
```


## References
[Kubernetes Deployments](https://kubernetes.io/docs/concepts/workloads/controllers/deployment)
[Kubernetes **deployment** Command](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#-em-deployment-em-)
