# GKE Training Module
## Activity 04 - Services

## Activity Objective
The purpose of this activity is to learn about services. They can be confusing at first. But hopefully by the time you are finished with this activity, you will have a better idea of their purpose in Kubernetes and how they work.

## What are services?
Services are Kubernetes resources that create a stable internal or external point of access for your application.
Service Types
### Cluster IP
Services of type **ClusterIP** are the default service type. They create a stable internal ip for your application.
### NodePort
Services of type **NodePort** create an access point on the node’s IP via a port for your application. Regardless of what node the application resides on, it will be accessible on all nodes because of the NodePort service. *Note, it will also create a Cluster IP service.
### LoadBalancer
Services of type **LoadBalancer** create an external load balancer that creates a single external access point for your application. *Note, it will also create a NodePort service and a Cluster IP service.
### Ingress
Services of type **Ingress** create an external load balancer with a proxy where url paths are mapped to ClusterIP or NodePort services. This creates a single external access point for all your applications that have a service mapped to the Ingress service.



#### View nodes with ip addresses
```
$ kubectl get nodes –output wide
```
or
```
$ kubectl get nodes -o wide  ← short form
```
Note all the internal and external ip addresses. How many are there in total?
> The default node pool has 3 nodes. There should an _internal ip_ and an _external ip_ for each node. A total of 6 ips addresses. We will refer to this later.

#### Create a pod called _testpod_
```
kubectl run testpod --image nginx
```

#### Deploy the _findme_ deployment YAML file
We can use the `kubectl apply -f FILENAME` command.
```
kubectl apply -f ./findme/findme.yaml
```

#### View pods with their IP addresses
```
$ kubectl get pods --output wide
```
or
```
$ kubectl get po -o wide  ← short form
```

How many pods are there?
> You should be able to see the **testpod** pod and the **find-me** pod

#### View the _find-me_ pod
```
$ kubectl describe pod find-me
```
or
```
$ kubectl get pod find-me -o yaml
```

What is the **find-me** pod internal IP?
> Better take a note!

What does the **find-me** pod todo label say?
> Let's use _CURL_

Note the find-me pod’s ip address
> We will refer to as [POD_IP_ADDRESS] in the next step

## Finding the _findme_ pod
#### Connect to the testpod pod and CURL the find-me pod
```
$ kubectl exec -it testpod – sh
# curl [POD_IP_ADDRESS]
```

What is the output?
> You should see the output “You found me!”

#### Type “exit” to disconnect from the pod.
```
# exit
```

### Cluster IP service
#### Create a ClusterIP service for the _find-me_ pod
```
$ kubectl expose pod find-me --name find-me-svc
```
> ClusterIp is the default. So if you don't specify a type, then it will be a service of type _ClusterIp_

#### View the services
```
$ kubectl get services
```
or
```
$ kubectl get svc  ← short form
```
> Running this command whenever you need to refer to the services’s IP addresses, port values, etc.. So feel free to use it often. It ends up being good practice!
How many services are there?
Which service can you see that you didn’t see in the Google Console?

#### Look at the find-me-svc service
```
$ kubectl describe svc find-me-svc 
```

What kind of service is it?

What is it’s IP address? We will refer to it as [SERVICE_IP_ADDRESS] in the next step.

What port is available on this service? We will refer to it as [SERVICE_PORT] in the next step.
> Better take notes!

#### Connect to the testpod pod and CURL the find-me-svc service
```
$ kubectl exec -it testpod – sh
# curl [SERVICE_IP_ADDRESS]:[SERVICE_PORT]
```

What is the output?
> Again, you should see the output “You found me!”

#### Type “exit” to disconnect from the testpod.
```
# exit
```

So far, how many IP_ADDRESS:PORT combinations have you successfully CURLed to?

> The answer is 2. Once to the find-me pod's IP and once to the find-me service ip.

### Node Port service
#### Create a NodePort service for the _find-me_ pod
```
$ kubectl expose pod find-me --name find-me-nodeport --target-port 80 --port 80 --type NodePort
```
> This will expose the find-me pod on each node's ip address on a specific port.

#### View the services
```
$ kubectl get services
```
or
```
$ kubectl get svc  ← short form
```
#### Look at the find-me-nodeport service
$ kubectl describe svc find-me-nodeport
 
What is it’s Cluster IP address?
> We will refer to it as [CLUSTERIP_ADDRESS] in the next step.

What port is available on the ClusterIP service?
> We will refer to it as [CLUSTERIP_PORT] in the next step.

What is the node port available on this service?
> We will refer to it as [NODE_PORT] in the next step.

#### Connect to the testpod pod and CURL the find-me-nodeport Cluster IP
```
$ kubectl exec -it testpod – sh
# curl [SERVICE_IP_ADDRESS]:[SERVICE_PORT]
```

What is the output?
> Again, you should see the output “You found me!”

#### Try with the [NODE_PORT] value
For reaching the find-me pod on the node port we need to curl a node internal or external ip on the nodeport value.
```
$ kubectl exec -it testpod – sh
# curl [SERVICE_IP_ADDRESS]:[NODE_PORT]
```


What is the output?
> Did you get an error?

#### Disconnect from the testpod.
```
# exit
```

Why didn’t it work?
> It didn’t work because for node ports we need to curl a NODE IP with the NODE_PORT.

### Connect to the find-me pod via the NodePort service
#### View the nodes
```
$ kubectl get nodes -o wide
```
> Note the internal IP [INTERNAL_IP] and the external IP [EXTERNAL_IP] of the first node.

#### First connect to the testpod
```
$ kubectl exec -it testpod – sh
```

#### CURL the node’s internal ip with the node port.
```
# curl [INTERNAL_IP]:[NODE_PORT]
```

What is the output?
> Now you should see the output “You found me!”

#### CURL the node’s external ip with the node port.
```
# curl [EXTERNAL_IP]:[NODE_PORT]
```

What is the output?
> Again, you should see the output “You found me!”

Have you tried to connect to EXTERNAL_IP:NODE_PORT from your browser? What happened?
How about by CURLing from your cloud shell terminal?
```
	ex: $ curl [EXTERNAL_IP]:[NODE_PORT]
```

Try doing the same with the other nodes' internal and external IPs.

You can access the application from your terminal and browser because services of type NodePort expose the application on the node’s IP address. If the node’s external IP address is accessible to the internet, then you don’t need to be on the Cluster network to access the application on the nodes.
> You may have to configure your network and firewall rules to allow access to these ip addresses.

So far, how many IP_ADDRESS:PORT combinations have you successfully CURLed to?
> With a single Nodeport service, you should be able to CURL to 7 additional points.
1. Node 1 [INTERNAL_IP]:[NODE_PORT]
1. Node 1 [EXTERNAL_IP]:[NODE_PORT]
1. Node 2 [INTERNAL_IP]:[NODE_PORT]
1. Node 2 [EXTERNAL_IP]:[NODE_PORT]
1. Node 3 [INTERNAL_IP]:[NODE_PORT]
1. Node 3 [EXTERNAL_IP]:[NODE_PORT]
1. [CLUSTERIP_IP:[CLUSTERIP_PORT]

> We are up to 9 different points that we can connect to.

#### Type “exit” to disconnect from the testpod.
```
# exit
```
### Connect to a Load Balancer service 
#### Create a service of type LoadBalancer
```
$ kubectl expose pod find-me --name find-me-loadbalancer --target-port 80 --port 80 --type LoadBalancer
```

```
$ kubectl get services
```
or
```
$ kubectl get svc  ← short form
```

### Look at the find-me-loadbalancer service
```
$ kubectl describe svc find-me-loadbalancer
```

What is it’s Cluster IP address?
> We will refer to it as [CLUSTERIP_ADDRESS] in the next step.

What port is available on the ClusterIP service?
> We will refer to it as [CLUSTERIP_PORT] in the next step.

What is the node port available on this service?
> We will refer to it as [NODE_PORT] in the next step.

What is the external IP available on this service?
> We will refer to it as [LB_IP] in the next step.

Remember the first Node’s [INTERNAL_IP] and [EXTERNAL_IP]? If not, just check again.

#### View nodes with ip addresses
```
$ kubectl get nodes –output wide
```
or
```
$ kubectl get nodes -o wide  ← short form
```

#### Connect to the testpod
```
$ kubectl exec -it testpod – sh
```

#### Try the follow curl commands
```
# curl [CLUSTERIP_ADDRESS]:[CLUSTERIP_PORT]
# curl [INTERNAL_IP]:[NODE_PORT]
# curl [EXTERNAL_IP]:[NODE_PORT]
# curl [LB_IP]:[CLUSTERIP_PORT]
```

What is the output?

How many more combinations can you CURL?

So far, how many IP_ADDRESS:PORT combinations have you successfully CURLed to?
> With a single Loadbalancer service, you should be able to CURL to 8 additional points.
1. [LOADBALANCER_IP]:[PORT]
1. Node 1 [INTERNAL_IP]:[NODE_PORT]
1. Node 1 [EXTERNAL_IP]:[NODE_PORT]
1. Node 2 [INTERNAL_IP]:[NODE_PORT]
1. Node 2 [EXTERNAL_IP]:[NODE_PORT]
1. Node 3 [INTERNAL_IP]:[NODE_PORT]
1. Node 3 [EXTERNAL_IP]:[NODE_PORT]
1. [CLUSTERIP_IP:[CLUSTERIP_PORT]

> This makes 17 different points that we can connect to in total!

How many of these can you access from the browser?
How many of these can you access by CURLing from your cloud shell terminal?
**ex:**
```
$ curl [EXTERNAL_IP]:[NODE_PORT]
```
> You can access the application from your terminal and browser because services of type Loadbalancer expose the application on an external IP address. If the Loadbalancer’s external IP address is accessible to the internet, then you don’t need to be on the Cluster network to access the application.

#### Type “exit” to disconnect from the testpod.
```
# exit
```

Continue to the next page.
Connect to an Ingress service
View the Ingresses
```
$ kubectl get ingress
```

How many ingress services are there?
View the webapp Ingress details
```
$ kubectl describe ingress webapp-ingress
```

How many paths are there?

Do they all work?

What kind of services are being used in the webapp-ingress Ingress?
Challenge
How many IP:PORT combinations can you curl to get the “You found me!” message from the find-me app?


Try curling the service find-me-svc-2
```
$ kubectl get svc
```

> Note find-me-svc-2 IP address [SERVICE_IP_ADDRESS] and Port number [SERVICE_PORT]

#### Connect to the testpod pod and CURL the find-me-svc-2 service
```
$ kubectl exec -it testpod – sh
# curl [SERVICE_IP_ADDRESS]:[SERVICE_PORT]
```

What is the output?

#### Type “exit” to disconnect from the testpod.
```
# exit
```


#### Troubleshoot
Why didn’t it work? Let’s identify the issue by getting more details about the service.
```
$ kubectl describe svc find-me-svc-2
```

Look at the target port value and the port value.

What is the problem?


## GCP Cloud Console
#### View the cluster in the Google Cloud Console
1. Go to **Kubernetes Engine**
1. Go to **Workloads**
1. View the workloads - How many pods do you see? How many deployments?
1. Go to Services & Ingress
1. View the **SERVICES**
  1. How many services do you see?
  1. How many Cluster IP Services do you see?
  1. How many Node Ports?
  1. How many Load Balancers?
1. Click on **INGRESS**
  1. How many Ingresses do you see?
  1. How many Services are associated with webapp-ingress?
1. Click the drop down arrow
  1. How many urls do you see?
  1. Do they both work?


