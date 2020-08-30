#!/usr/bin/env bash

# Setup Aliases
alias k='kubectl'
alias ns='kubectl config set-context --current --namespace'
alias kurrent='kubectl config view --minify -o "jsonpath={..namespace}" | xargs -I %s echo "Current Namespace: %s"'
alias nodetop='k get nodes | grep Ready | cut -d" " -f1 | xargs kubectl describe node | grep -E "Name: |cpu |memory "'  

# Setup vim
curl -Lo ~/.vimrc https://gist.github.com/simonista/8703722/raw/d08f2b4dc10452b97d3ca15386e9eed457a53c61/.vimrc

# Install Helm
curl https://baltocdn.com/helm/signing.asc | sudo apt-key add -
sudo apt-get install apt-transport-https --yes
echo "deb https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update
sudo apt-get install helm --yes

# Add helm repo
helm repo add stable https://kubernetes-charts.storage.googleapis.com
