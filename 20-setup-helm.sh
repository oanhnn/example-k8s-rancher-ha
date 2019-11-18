#!/bin/bash

#export KUBECONFIG=$(pwd)/kube_config_cluster.yml
set -ex

# Create the ServiceAccount in the kube-system namespace.
kubectl -n kube-system create serviceaccount tiller

# Create the ClusterRoleBinding to give the tiller account access to the cluster.
kubectl create clusterrolebinding tiller \
  --clusterrole=cluster-admin \
  --serviceaccount=kube-system:tiller

# Finally use helm to install the tiller service on the cluster
helm init --service-account tiller

# Verify the installation of tiller on your cluster
kubectl -n kube-system  rollout status deploy/tiller-deploy

# Validate helm can talk to the tiller service
helm version
