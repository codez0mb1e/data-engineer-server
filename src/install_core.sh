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


# Disks and network ----
# Attach new Azure disk
# https://learn.microsoft.com/en-us/azure/virtual-machines/linux/attach-disk-portal

# list of disks
lsblk -o NAME,HCTL,SIZE,MOUNTPOINT | grep -i "sd"

sudo parted /dev/sdb --script mklabel gpt mkpart xfspart xfs 0% 100%
sudo mkfs.xfs /dev/sdb1
sudo partprobe /dev/sdb1

# disks stuff
ls /mnt
# mount data disc (optional)
sudo mkdir /mnt/datadrive
sudo mount /dev/sdb1 /mnt/datadrive
df -Th

# remount disk on reboot
sudo blkid # get UUID, e.g. 000000-6389-4c96-872c-55ec08863bff
sudo nano /etc/fstab
# UUID=000000-6389-4c96-872c-55ec08863bff   /mnt/datadrive   xfs   defaults,nofail   1   2

# verify results
sudo reboot
lsblk -o NAME,HCTL,SIZE,MOUNTPOINT | grep -i "sd"

# IO
sudo iotop -o

# network stuff
sudo iftop -i eth0

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
