#!/bin/bash

function __install_rke() {
    VERSION=${1-'v0.3.2'}
    curl -sL -o ./rke https://github.com/rancher/rke/releases/download/${VERSION}/rke_linux-amd64
    chmod +x ./rke
    mv ./rke /usr/local/bin/rke
}

function __install_kubectl() {

    VERSION=${1:-'v1.16.3'}
    curl -sL -o ./kubectl https://storage.googleapis.com/kubernetes-release/release/${VERSION}/bin/linux/amd64/kubectl
    chmod +x ./kubectl
    mv ./kubectl /usr/local/bin/kubectl
}


function __install_helm() {
    VERION=${1-'v2.16.1'}
    curl -sL https://get.helm.sh/helm-${VERION}-linux-amd64.tar.gz | tar -xz
    chmod +x ./linux-amd64/helm
    mv ./linux-amd64/helm /usr/local/bin/helm
    rm -rf ./linux-amd64
}

set -ex

# Install Kubectl
# Get latest stable version of kubectl by: curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt
__install_kubectl v1.16.3

# Install Helm v2.12.1 or higher
__install_helm v2.16.1

# Install RKE
__install_rke v0.3.2
