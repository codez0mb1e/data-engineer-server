#!/bin/bash

#
# Install core packages and tools
#


# Install updates ----
apt update
apt list --upgradable
apt upgrade -y 


# Install core packages ----
apt install -y build-essential libssl-dev cmake apt-transport-https


# PyPI issues ----
pip -V
pip install --upgrade pip
# or
apt install -y python3-pip


# Install utils ----
apt install -y htop ncdu


# Other  ----
# mount data disc (optional)
mkdir /datadrive
mount /dev/sda1 /datadrive
df -Th


# add users (optional)
USR="<user_name>"; readonly USR
adduser $USR
usermod -aG sudo $USR

# (optional, and not recommended) Allow authorization without public key
 nano /etc/ssh/sshd_config
 # uncomment this line:
 #> PasswordAuthentication yes