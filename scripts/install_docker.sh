#!/bin/bash

#
# Install docker and containers management
#


# 0. Prepare [1] ----

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | 
  sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | 
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null


# 1. Install ----

# Install packages
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io

# Create group [2]
sudo usermod -aG docker $USER
grep docker /etc/group
newgrp docker


# Verify
systemctl status docker
docker run hello-world


# 2. Management ----

docker ps -a

# Install Portainer [3]
docker volume create portainer_data

docker run -d -p 8000:8000 -p 9443:9443 \
  --name=portainer --restart=always \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v portainer_data:/data \
  portainer/portainer-ce:latest
  
# see result in https://localhost:9443

docker logs portainer


# 3. ACR ----
az login
az acr login -n <acr_name>

docker run -it --rm -p 80:80 -p 443:443 \
  --name=<name> \
  <acr_name>.azurecr.io/<name>:<tag>


# 4. Networks ----
docker network ls
docker network inspect host


# 5. GC ----
# removing all unused (containers, images, networks and volumes)
docker system prune -f

#! clean all
# docker system prune -a


# References ----
# 1. https://docs.docker.com/install/linux/docker-ce/ubuntu/
# 2. https://stackoverflow.com/questions/47854463/docker-got-permission-denied-while-trying-to-connect-to-the-docker-daemon-socke
# 3. https://docs.portainer.io/start/install/server/docker/linux
# 4. https://github.com/eon01/DockerCheatSheet
