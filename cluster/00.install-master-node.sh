#!/usr/bin/env bash

########################################################################################
###                                                                                  ###
###   This is a notebook of all steps to build up a K8s cluster.                     ###
###   Should use it as a reference rather than production script.                    ###
###                                                                                  ###
########################################################################################
set -e  # stop immediately if any error happens

SCRIPT_HOME=$(cd `dirname $BASH_SOURCE` && pwd)
POD_IP_RANGE="192.168.0.0/16"  # This IP Range is the default value of Calico

$SCRIPT_HOME/install-components.sh

# Init the cluster
sudo kubeadm init --pod-network-cidr=$POD_IP_RANGE --upload-certs | tee kubeadm-init.out

# Admin config for Master node
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

sudo apt-get install -y bash-completion
source <(kubectl completion bash)
echo "source <(kubectl completion bash)" >> ~/.bashrc

MASTER_NODE_IP=$(ip addr show | grep -E "inet.*ens4" | xargs | cut -d" " -f2 | cut -d\/ -f1)
echo "$MASTER_NODE_IP k8smaster" | sudo tee -a /etc/hosts


# Install Calico network. Ref. https://docs.projectcalico.org/v3.11/getting-started/kubernetes/installation/calico
kubectl apply -f https://docs.projectcalico.org/v3.11/manifests/rbac/rbac-kdd-calico.yaml
kubectl apply -f https://docs.projectcalico.org/v3.11/manifests/calico.yaml

# Verify installation
kubectl get pods --all-namespaces
echo ;echo "--> Use information bellow to add new nodes"
echo "- MASTER NODE IP: $MASTER_NODE_IP"
echo "- Run command bellow after run '01.add-worker-node.sh' worker node"
sudo kubeadm token create --print-join-command