#!/usr/bin/env bash

helm repo add stable https://kubernetes-charts.storage.googleapis.com
helm install stable/nfs-server-provisioner -f values.yaml
