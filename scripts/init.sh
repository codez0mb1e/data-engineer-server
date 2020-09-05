#!/bin/bash

#
# Install core libs and tools
#


# Install updates ----
apt update
apt list --upgradable
apt upgrade -y 


# Install core libs ----
apt install -y build-essential libssl-dev cmake


# PyPI issues ----
pip --version
pip install --upgrade pip


# Install utils ----
apt install -y htop ncdu


# Other  ----

# mount data disc (optional)
sudo mount /dev/sdc1 /datadrive
df -Th


# add users (optional)
$USR="<user_name>"; readonly $USR 
adduser $USR
usermod -aG sudo $USR
