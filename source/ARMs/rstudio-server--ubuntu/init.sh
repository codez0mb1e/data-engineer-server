#!/bin/bash

### summary: install ML-frameworks and R tools

# get args
usr=$1


## install updates ----
apt-get -y update
apt-get -y dist-upgrade

## core libs ----
apt-get -y install build-essential libssl-dev cmake


## install R and R tools ----
# warn: install CNTK, Tensorflow, Keras, Python tools before R installation
wget  https://mran.blob.core.windows.net/install/mro/3.4.4/microsoft-r-open-3.4.4.tar.gz
tar -xf microsoft-r-open-3.4.4.tar.gz
cd microsoft-r-open/
./install.sh -a -u
cd .
 
R --version


# RStudio Server
apt-get install gdebi-core
wget https://download2.rstudio.org/rstudio-server-1.1.447-amd64.deb
gdebi -q rstudio-server-1.1.447-amd64.deb

rstudio-server status


# R-packages dependencies
apt-get -y install gfortran libcurl4-openssl-dev 

# install SQL Server drivers
sudo su 
curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list > /etc/apt/sources.list.d/mssql-release.list
exit 

apt-get update
ACCEPT_EULA=Y apt-get install msodbcsql
apt-get -y install unixodbc unixodbc-dev #? tdsodbc


## install LightGBM ----
# see for GPU version install: http://lightgbm.readthedocs.io/en/latest/Installation-Guide.html#id6

# CPU version install
git clone --recursive https://github.com/Microsoft/LightGBM ; cd LightGBM
mkdir build ; cd build
cmake ..
make -j4

# or run in RStudio
#    library(devtools)
#    options(devtools.install.args = "--no-multiarch") # if you have 64-bit R only, you can skip this
#    install_github("Microsoft/LightGBM", subdir = "R-package")


## install tools ----
apt-get -y install htop # and git, nvidia-smi if not already installed

adduser <user>

git config --global user.name "Dmitry Petukhov"
git config --global user.email "dpetukhov@***.com"
git config --list

# see more on https://docs.microsoft.com/en-us/vsts/git/use-ssh-keys-to-authenticate?view=vsts
ssh-keygen -C "dpetukhov@***.com"
cat /home/<user>/.ssh/id_rsa.pub

mkdir apps
cd apps
git clone ssh://<server>@vs-ssh.visualstudio.com:22/DefaultCollection/_ssh/<repo>

