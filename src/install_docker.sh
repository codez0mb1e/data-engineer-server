#!/bin/bash

#
# Install docker and containers management
#


# 0. Prepare [1] ----
# add Docker's official GPG key:
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# 1. Install ----
# install packages
sudo apt -y update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# create group [2]
sudo usermod -aG docker $USER
# activate changes
newgrp docker
# check
grep docker /etc/group

# verify
systemctl status docker
docker compose version

# more info
docker info


# 2. Containers management ----
docker ps -a

# install Portainer [3]
docker run -d \
  -p 9443:9443 \
  --restart unless-stopped \
  -v /data/portainer:/data \
  -v /var/run/docker.sock:/var/run/docker.sock
  --name portainer \
  portainer/portainer-ce:latest

# see result in https://localhost:9443
docker logs portainer


# 3. Connect to Docker registries ----
# Docker Hub
docker login -u <username> -p <password>

# Azure Container Registry
az login
az acr login -n <acr_name>

docker run -it --rm -p 80:80 -p 443:443 \
  --name=<name> \
  <acr_name>.azurecr.io/<name>:<tag>


# 4. Networks ----
docker network ls
docker network inspect host

# "port already in use" issue
sudo lsof -i :80
sudo systemctl stop nginx # or other service, e.g. apache2


# X. GC ----
# removing all unused (containers, images, networks and volumes)
docker system prune -f
# or (WARN) clean all
# docker system prune -a

# restarting
sudo systemctl restart docker


# References ----
# 1. https://docs.docker.com/install/linux/docker-ce/ubuntu/
# 2. https://stackoverflow.com/questions/47854463/docker-got-permission-denied-while-trying-to-connect-to-the-docker-daemon-socke
# 3. https://earthly.dev/blog/portainer-for-docker-container-management/
