# Deployment Instructions

## Prerequisites

* Portworx and stork are installed on the cluster
* If Portworx and stork are not installed use an appropriate storageclass and
change the schedulerName in the app specs

## Install helm

Instructions to install are here: https://helm.sh/docs/using_helm/#install-helm

After installing update the service account for tiller
```
kubectl create serviceaccount --namespace kube-system tiller
kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
kubectl patch deploy --namespace kube-system tiller-deploy -p '{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}'
```

## Create the storageclass
```
kubectl apply -f 01-sc.yaml
```

## Install kafka and zookeeper
```
helm repo add incubator http://storage.googleapis.com/kubernetes-charts-incubator
helm install --name kafka incubator/kafka --namespace kafka --set persistence.enabled=true,persistence.size=100Gi,persistence.storageClass=px-repl3
```

## Create the WordCount stream app
```
kubectl apply -f 02-stream-sts.yaml
```
