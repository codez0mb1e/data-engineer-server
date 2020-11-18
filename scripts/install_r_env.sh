#!/bin/bash

#
# Install R: dependencies, runtime, IDE, tools
#


# Set params ----
USR="<user_name>"; readonly USR
RSTUDIO_SERVER_VERSION="1.3.1093"; readonly RSTUDIO_SERVER_VERSION # note: check number of latest version [1]


# R-packages dependencies ----
apt install -y gfortran libxml2-dev libssl-dev libcurl4-openssl-dev


# Install R CRAN ----
# add the CRAN gpg key
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran40/'

apt update
apt install -y r-base

# validate R installation
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
# For SQL Server connection support see [2-4]


# References ----
# 1. https://rstudio.com/products/rstudio/download-server/
# 2. https://db.rstudio.com/databases/microsoft-sql-server/
# 3. https://docs.microsoft.com/en-us/sql/connect/odbc/linux-mac/installing-the-microsoft-odbc-driver-for-sql-server?view=sql-server-ver15#ubuntu17
# 4. https://db.rstudio.com/best-practices/drivers/#linux-debian-ubuntu
