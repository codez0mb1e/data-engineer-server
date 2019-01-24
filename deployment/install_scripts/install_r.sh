#!/bin/bash

#
# Install R: dependencies, runtime, IDE, tools
#



# R-packages dependencies ----
apt-get -y install gfortran libxml2-dev libssl-dev libcurl4-openssl-dev libopenblas-dev
# optional: apt-get install -y r-base r-base-dev


# Install Microsoft R Open ----
wget https://mran.blob.core.windows.net/install/mro/3.5.1/microsoft-r-open-3.5.1.tar.gz
tar -xf microsoft-r-open-3.5.1.tar.gz
cd microsoft-r-open
./install.sh -a -u
cd ~

R --version



# Install RStudio Server ----
# add user for RStudio
adduser <username>

apt-get -y install gdebi-core
wget https://download2.rstudio.org/rstudio-server-1.1.463-amd64.deb
gdebi --quiet rstudio-server-1.1.463-amd64.deb

rstudio-server status

# fix 'memory not mapped' error
wget https://mirrors.kernel.org/ubuntu/pool/main/libp/libpng/libpng12-0_1.2.54-1ubuntu1_amd64.deb
dpkg -i libpng12-0_1.2.54-1ubuntu1_amd64.deb


# Install SQL Server drivers
sudo su 
curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
curl https://packages.microsoft.com/config/ubuntu/18.04/prod.list > /etc/apt/sources.list.d/mssql-release.list
exit 

apt-get update
ACCEPT_EULA=Y apt-get install msodbcsql

apt-get -y install unixodbc unixodbc-dev #? tdsodbc
