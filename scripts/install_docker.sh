#!/bin/bash

#
# Install docker 
#


# 0. Prepare [1] ----
apt update
apt install -y apt-transport-https ca-certificates curl gnupg lsb-release

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null


# 1. Install ----

# Install packages
apt update
apt install -y docker-ce docker-ce-cli containerd.io

# Create group [2]
usermod -aG docker $USER
grep docker /etc/group
newgrp docker


# Verify ----
systemctl status docker
docker run hello-world


# References ----
# 1. https://docs.docker.com/install/linux/docker-ce/ubuntu/
# 2. https://stackoverflow.com/questions/47854463/docker-got-permission-denied-while-trying-to-connect-to-the-docker-daemon-socke
