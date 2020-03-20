#!/bin/bash

#
# Install R: dependencies, runtime, IDE, tools
#


# Set params ----
USR="<user_name>"; readonly USR
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

# validate R Open installation
R --version 


# Install RStudio Server ----
# add user for RStudio
adduser $USR

apt install -y gdebi-core
wget https://download2.rstudio.org/server/bionic/amd64/rstudio-server-${RSTUDIO_SERVER_VERSION}-amd64.deb
gdebi --quiet rstudio-server-${RSTUDIO_SERVER_VERSION}-amd64.deb

# validate RStudio installation
rstudio-server status


# SQL Server drivers  ----
# For SQL Server connection support see [1]



# References ----
# 1. https://db.rstudio.com/databases/microsoft-sql-server/
# 2. https://docs.microsoft.com/en-us/sql/connect/odbc/linux-mac/installing-the-microsoft-odbc-driver-for-sql-server?view=sql-server-ver15#ubuntu17
# 3. https://db.rstudio.com/best-practices/drivers/#linux-debian-ubuntu
