#!/bin/bash

#
# Install core packages and tools
#


# Discover yourself ----
whoami
groups | grep sudo


# Install updates ----
sudo apt update
apt list --upgradable
sudo apt upgrade -y 


# Install core packages ----
sudo apt install -y build-essential libssl-dev cmake apt-transport-https ca-certificates curl lsb-release gnupg


# Install utils ----
sudo apt install -y htop iftop iotop ncdu


# Other  ----
# mount data disc (optional)
mkdir /datadrive
mount /dev/sda1 /datadrive
df -Th


# add users (optional)
USR="<user_name>"; readonly USR
sudo adduser $USR
sudo usermod -aG sudo $USR

# (optional, but not recommended) Allow authorization without public key
nano /etc/ssh/sshd_config
# uncomment this line:
#> PasswordAuthentication yes

# Save changes and reload service
service sshd restart


# Refernces
# 1. https://devconnected.com/how-to-install-and-enable-ssh-server-on-ubuntu-20-04/
 