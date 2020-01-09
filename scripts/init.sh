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


# Install utils ----
apt install -y htop ncdu


# Other  ----
# mount data disc (optional)
sudo mount /dev/sdc1 /datadrive
df - Th

# add users (optional)
adduser <user_name>
usermod -aG sudo <user_name>
