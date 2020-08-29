#!/usr/bin/env bash

helm repo add bitnami https://charts.bitnami.com/bitnami
helm install mariadb bitnami/mariadb -f values.yaml
