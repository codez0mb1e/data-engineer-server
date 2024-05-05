#!/bin/bash

#
# Install core packages and tools
#


# Discover yourself ----
# OS info
uname -a

# Hardware info
lscpu | grep "Model name" # CPU
free -h # RAM
lsblk -f # Disks
ip a # Network

# User info
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


# Disk and network ----
# disks stuff
ls /mnt
# mount data disc (optional)
mkdir /mnt/datadrive
mount /dev/sdb1 /mnt/datadrive
df -Th
# IO
sudo iotop -o

# network stuff
sudo iftop


# New user ----
# add users (optional)
groups | grep sudo

USR="<user_name>"; readonly USR
sudo adduser $USR
sudo usermod -aG sudo $USR

# (optional, but not recommended) Allow authorization without public key
sudo nano /etc/ssh/sshd_config
# uncomment this line:
#> PasswordAuthentication yes

# save changes and reload service
sudo service ssh restart
systemctl status ssh


# Cookies ----
sudo apt install -y cmatrix
cmatrix
