#!/bin/bash

DOMAIN=${1-'rancher.example.org'}
ALERT_EMAIL=${2-'me@example.org'}

#export KUBECONFIG=$(pwd)/kube_config_cluster.yml
set -ex

# Use `helm repo add` command to add the Helm chart repository that contains charts to install Rancher.
helm repo add rancher-stable https://releases.rancher.com/server-charts/stable

# Install rancher with option `ingress.tls.source=letsEncrypt`
helm install rancher-stable/rancher \
  --name rancher \
  --namespace cattle-system \
  --set hostname=${DOMAIN} \
  --set ingress.tls.source=letsEncrypt \
  --set letsEncrypt.email=${ALERT_EMAIL}

# Verify the installation of rancher on your cluster
kubectl -n cattle-system rollout status deploy/rancher
