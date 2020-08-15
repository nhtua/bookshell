#!/usr/bin/env bash
mkdir -p /home/jenkins/data
cd /home/jenkins
docker run -v /var/run/docker.sock:/var/run/docker.sock -v $(which docker):$(which docker) -v `pwd`/data:/var/jenkins_home  -p 8080:8080  --user 1000:999 --name jenkins-server -d jenkins/jenkins:lts
