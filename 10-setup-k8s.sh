#!/bin/bash

set -ex

# Install Kubernetes with RKE
# When finished, it should end with the line: "Finished building Kubernetes cluster successfully."
rke up --config ./cluster.yml

# Save the credentials for kubectl and helm
if [[ -f $HOME/.kube/config ]]; then
    cp $HOME/.kube/config $HOME/.kube/config-backup
fi
cp ./kube_config_cluster.yml $HOME/.kube/config

# If you are working with multiple Kubernetes clusters,
# set the KUBECONFIG environmental variable to the path of kube_config_cluster.yml
#export KUBECONFIG=$(pwd)/kube_config_cluster.yml

# Test your cluster connectivity with kubectl and see if all your nodes are in "Ready state"
kubectl get nodes

# Check that all the required pods and containers are healthy are ready to continue
kubectl get pods --all-namespaces
