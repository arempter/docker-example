# Makisu build example

## Prepare K8s

Add Redis

```
$ cd k8s
$ create -f redis.yaml
```

Edit and create registry secret

```
$ kubectl create secret generic docker-registry-config — from-file=./registry.yaml
```

Edit and submit job

```
$ kubeclt create -f build_scala_app_job.yaml
```  

Watch created jobs

```
$ kubectl get pods --watch
``` 
 