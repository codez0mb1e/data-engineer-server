#!/bin/bash

## Get params
usr=$1
password=$2
#rstudio="rstudio-server-"$3"-amd64.deb"


## Install last updates
apt-get -y update
apt-get -y upgrade
apt-get -y dist-upgrade


### configure One-Box ML Server
#/usr/local/bin/dotnet /opt/microsoft/mlserver/9.2.1/o16n/Microsoft.MLServer.Utils.AdminUtil/Microsoft.MLServer.Utils.AdminUtil.dll -silentoneboxinstall "$password"
#iptables --flush
#
#
### Install R dependencies
## R-packages (common)
#apt-get -y install build-essential
#apt-get -y install libcurl4-openssl-dev libssl-dev
#apt-get -y install gfortran
#
## LightGBM
#mkdir -p /home/$usr/apps/LightGBM
#apt-get -y install cmake
#apt-get -y install glibc-source
#
#
### RStudio Server installer
#apt-get -y install gdebi-core
#wget https://download2.rstudio.org/$rstudio
#gdebi --n $rstudio
#rstudio-server verify-installation
##rm $rstudio

# tools
apt-get -y install htop
