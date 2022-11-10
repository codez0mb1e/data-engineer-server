#!/bin/bash

#
# Install core packages and tools
#


# Discover yourself ----
# OS info
uname -a
whoami


# Install updates ----
sudo add-apt-repository universe

sudo apt update
apt list --upgradable
sudo apt upgrade -y 


# Install core packages ----
sudo apt install -y build-essential libssl-dev cmake apt-transport-https ca-certificates curl lsb-release gnupg


# Install utils ----
sudo apt install -y htop iftop iotop ncdu


# Other  ----
# disks stuff
ls /mnt
lsblk -f
# mount data disc (optional)
mkdir /mnt/datadrive
mount /dev/sdb1 /mnt/datadrive
df -Th

# network stuff
ifconfig 
# or
ip addr show eth0
# or
iftop

netstat -tulpn

# add users (optional)
groups | grep sudo

USR="<user_name>"; readonly USR
sudo adduser $USR
sudo usermod -aG sudo $USR

# (optional, but not recommended) Allow authorization without public key
nano /etc/ssh/sshd_config
# uncomment this line:
#> PasswordAuthentication yes

# save changes and reload service
service sshd restart


# Cookies ----
apt install cmatrix
cmatrix


# References
# 1. https://devconnected.com/how-to-install-and-enable-ssh-server-on-ubuntu-20-04/
 