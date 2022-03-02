#### View pods in the default namespace
```
$ kubectl get pods
```
or
```
$ kubectl get po  ← short form
```

Note the names
#### View pods in the blue namespace
```
$ kubectl get pods –namespace blue
```
or
```
$ kubectl get po -n blue ← short form
```

How many pods are there?

#### View pods in the _red_ namespace
```
$ kubectl get pods –namespace red
```
or
```
$ kubectl get po -n red ← short form
```

#### View pods in the **yellow** namespace
```
$ kubectl get pods –namespace yellow
```
or
```
$ kubectl get po -n yellow ← short form
```

## TO DO
LOOK AT RESTRICTING PERMISSION WITH ROLE BINDINGS

~Notice that you don’t have permissions? That is the advantage of namespaces. You can limit who has access to what.~

### Check your access.
```
$ kubectl auth can-i get pods
```
The answer should be “yes”

#### Check your access to the pods in the _red_ namespace
```
$ kubectl auth can-i get pods -n red
```
The answer should be “yes”

#### Check your access to the pods in the _blue_ namespace
```
$ kubectl auth can-i get pods -n blue
```
The answer should be “yes”

#### Check your access to the pods in the _yellow_ namespace
```
$ kubectl auth can-i get pods -n yellow
```
The answer should be “no” 


What happens if you delete a namespace?

#### Delete the **red** namespace
```
$ kubectl delete ns red
```



