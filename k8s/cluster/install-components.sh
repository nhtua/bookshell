#!/usr/bin/env bash
set -e  # halt if any error occurs

K8S_VERSION="1.16.4-00" # K8s is changed regularly. I just want to keep this script stable with v1.16

echo "--> STEP 01. check requirements"
sudo swapoff -a
SWAP_MEM=$(cat /proc/meminfo | grep 'SwapTotal' | cut -d":" -f2 | xargs | cut -d" " -f1)
if [[ ! $SWAP_MEM -eq 0 ]]; then
    echo "ERROR: cannot turn of swap memory on this node."
    exit 1
fi
sudo apt-get update
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y



echo "--> STEP 02. install Docker"  # ref https://kubernetes.io/docs/setup/production-environment/container-runtimes/
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
cat <<EOF | sudo tee /etc/apt/sources.list.d/docker.list
deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable
EOF

sudo apt-get update
sudo apt remove docker docker-engine docker.io
sudo apt-get update
sudo apt-get install -y \
  containerd.io=1.2.10-3 \
  docker-ce=5:19.03.4~3-0~ubuntu-$(lsb_release -cs) \
  docker-ce-cli=5:19.03.4~3-0~ubuntu-$(lsb_release -cs)
sudo usermod -aG docker $USER

# Setup daemon.
cat <<EOF | sudo tee /etc/docker/daemon.json
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF
sudo mkdir -p /etc/systemd/system/docker.service.d

# Restart docker.
sudo systemctl daemon-reload
sudo systemctl restart docker



echo "--> STEP 03. install Kubernetes components"
curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
sudo apt-get update
sudo apt-get install -y kubeadm=$K8S_VERSION kubelet=$K8S_VERSION kubectl=$K8S_VERSION
sudo apt-mark hold kubeadm kubelet kubectl  # Choose to stop upgrading
