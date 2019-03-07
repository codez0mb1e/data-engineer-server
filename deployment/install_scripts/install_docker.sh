#!/bin/bash

#
# Install docker 
#


apt install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -


# verify that you now have the key with the fingerprint 9DC8 5822 9FC7 DD38 854A E2D8 8D81 803C 0EBF CD88
apt-key fingerprint 0EBFCD88

add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
   
apt update
apt install -y docker-ce docker-ce-cli containerd.io


groupadd docker
usermod -aG docker $USER

docker run hello-world


# References ----
# https://docs.docker.com/install/linux/docker-ce/ubuntu/
