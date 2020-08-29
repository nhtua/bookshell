#!/usr/bin/env bash

helm repo add stable https://kubernetes-charts.storage.googleapis.com
helm install my-release bitnami/wordpress -f values.yaml
