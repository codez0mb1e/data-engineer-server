#!/bin/bash

## params
usr = $1
password = $2


## install last updates
apt-get -y update
apt-get -y upgrade
apt-get -y dist-upgrade


## configure One-Box ML Server
/usr/local/bin/dotnet /opt/microsoft/mlserver/9.2.1/o16n/Microsoft.MLServer.Utils.AdminUtil/Microsoft.MLServer.Utils.AdminUtil.dll -silentoneboxinstall $password
iptables --flush


## install R dependencies
# RStudio installer
apt-get -y install gdebi-core
# R-packages (common)
apt-get -y install build-essential
apt-get -y install libcurl4-openssl-dev libssl-dev
apt-get -y install gfortran
# LightGBM
apt-get -y install git
mkdir -p /home/$usr/apps/LightGBM
git clone --recursive https://github.com/Microsoft/LightGBM /home/$usr/apps/LightGBM
apt-get -y install cmake
apt-get -y install glibc-source

## dev tools
apt-get -y install htop
