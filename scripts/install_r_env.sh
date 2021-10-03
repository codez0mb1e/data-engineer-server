#!/bin/bash

#
# Install R: dependencies, runtime, IDE, tools
#


# Set params ----
RSTUDIO_SERVER_VERSION="1.4.1717"; readonly RSTUDIO_SERVER_VERSION # note: check number of latest version [1]


# R-packages dependencies ----
apt install -y gfortran libxml2-dev libssl-dev libcurl4-openssl-dev


# Install R CRAN ----
# update indices
apt update -qq
# install two helper packages we need
apt install --no-install-recommends software-properties-common dirmngr
# add the signing key (by Michael Rutter) for these repos
wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | sudo tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
# add the R 4.0 repo from CRAN
add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"

apt install --no-install-recommends -y r-base

# validate R installation
R --version


# Install RStudio Server ----
apt install -y gdebi-core
wget https://download2.rstudio.org/server/bionic/amd64/rstudio-server-${RSTUDIO_SERVER_VERSION}-amd64.deb
gdebi --quiet rstudio-server-${RSTUDIO_SERVER_VERSION}-amd64.deb

# validate RStudio installation
rstudio-server status

# add user for connection with RStudio via SSH tunnel  (if not yet)
adduser "<user_name>"


# Install dependencies for R packages  ----
# Reticulate
apt install -y libpng-dev 

# For SQL Server connection support see [2-4]
# apt install -y unixodbc-dev
# apt install -y r-cran-odbc


# Set R package binaries source https://launchpad.net/~c2d4u.team/+archive/ubuntu/c2d4u4.0+
add-apt-repository ppa:c2d4u.team/c2d4u4.0+
apt update


# References ----
# 1. https://cran.r-project.org/
# 2. https://rstudio.com/products/rstudio/download-server/
# 3. https://db.rstudio.com/databases/microsoft-sql-server/
# 4. https://docs.microsoft.com/en-us/sql/connect/odbc/linux-mac/installing-the-microsoft-odbc-driver-for-sql-server?view=sql-server-ver15#ubuntu17
# 5. https://db.rstudio.com/best-practices/drivers/#linux-debian-ubuntu
# 6. https://rtask.thinkr.fr/installation-of-r-4-0-on-ubuntu-20-04-lts-and-tips-for-spatial-packages/
