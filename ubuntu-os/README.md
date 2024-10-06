# Ubuntu 24.04: core commands, packages and tools

- [Discover](#discover)
- [Install updates](#install-updates)
- [Core packages/utils](#core-packagesutils)
- [Disks and network](#disks-and-network)
- [New user](#new-user)
- [Cookies](#cookies)


## Discover

OS info:

```bash
uname -a
```

Hardware info:
    
```bash
lscpu | grep "Model name" # CPU
free -h # RAM
lsblk -f # Disks
ip a # Network
```

User info/permissions:

```bash
whoami
groups | grep sudo
```

## Install updates

```bash
sudo add-apt-repository universe

sudo apt update
apt list --upgradable
sudo apt upgrade -y
```

## Core packages/utils

Packages:

```bash
sudo apt install -y \
    build-essential \
    libssl-dev \
    cmake \
    apt-transport-https \
    curl
```

Utils:

```bash
sudo apt install -y htop iftop iotop ncdu tree 
```

## Disks and network

```bash
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
```

## New user

```
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
```

## Cookies

Matrix screensaver:

```bash
sudo apt install -y cmatrix
cmatrix
```
