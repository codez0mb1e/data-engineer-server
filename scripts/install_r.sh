#!/bin/bash

#
# Install R: dependencies, runtime, IDE, tools
#


# Set params ----
USR="dp"; readonly USR
R_VERSION="3.5.3"; readonly R_VERSION
RSTUDIO_SERVER_VERSION="1.2.5033"; readonly RSTUDIO_SERVER_VERSION


# R-packages dependencies ----
apt install -y gfortran libxml2-dev libssl-dev libcurl4-openssl-dev


# Install Microsoft R Open ----
wget https://mran.blob.core.windows.net/install/mro/${R_VERSION}/ubuntu/microsoft-r-open-${R_VERSION}.tar.gz
tar -xf microsoft-r-open-${R_VERSION}.tar.gz
cd microsoft-r-open
./install.sh -a -u
cd ~

# fix 'memory not mapped' error
wget https://mirrors.kernel.org/ubuntu/pool/main/libp/libpng/libpng12-0_1.2.54-1ubuntu1_amd64.deb
dpkg -i libpng12-0_1.2.54-1ubuntu1_amd64.deb

# validate R Open installation
rstudio-server verify-installation
# or
R --version 


# Install RStudio Server ----
# add user for RStudio
adduser $USR

apt install -y gdebi-core
wget https://download2.rstudio.org/server/bionic/amd64/rstudio-server-${RSTUDIO_SERVER_VERSION}-amd64.deb
gdebi --quiet rstudio-server-${RSTUDIO_SERVER_VERSION}-amd64.deb

# validate RStudio installation
rstudio-server status


# SQL Server drivers ----
sudo su
curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
curl https://packages.microsoft.com/config/ubuntu/18.04/prod.list > /etc/apt/sources.list.d/mssql-release.list
exit

apt update
ACCEPT_EULA=Y apt install msodbcsql17
apt install -y unixodbc-dev


# install for keras
apt install -y python-pip python-virtualenv

# validate installation
Rscript -e "install.packages('keras');library(keras);install_keras(tensorflow='gpu')"


# References ----
# 1. https://docs.microsoft.com/en-us/sql/connect/odbc/linux-mac/installing-the-microsoft-odbc-driver-for-sql-server?view=sql-server-2017
# 2. https://db.rstudio.com/databases/microsoft-sql-server/
