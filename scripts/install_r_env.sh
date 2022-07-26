#!/bin/bash

#
# Install R: dependencies, runtime, IDE, tools
#


# Set params ----
RSTUDIO_SERVER_VERSION="2022.07.1-554"; readonly RSTUDIO_SERVER_VERSION # note: check number of latest version [2]

# R-packages dependencies ----
sudo apt install -y gfortran libxml2-dev libssl-dev libcurl4-openssl-dev


# Install R CRAN [1] ----
# update indices
sudo apt update -qq
# install two helper packages we need
sudo apt install --no-install-recommends software-properties-common dirmngr
# add the signing key (by Michael Rutter) for these repos
wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | sudo tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
# add the R 4.0 repo from CRAN
sudo add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"

sudo apt install --no-install-recommends -y r-base

# validate R installation
R --version


# Install RStudio Server ----
sudo apt install -y gdebi-core
wget https://download2.rstudio.org/server/bionic/amd64/rstudio-server-${RSTUDIO_SERVER_VERSION}-amd64.deb
sudo gdebi --quiet rstudio-server-${RSTUDIO_SERVER_VERSION}-amd64.deb

# validate RStudio installation
rstudio-server status


# Install dependencies for R packages  ----

# SQL Server connection support
# Install drivers [4]
sudo su
curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
curl https://packages.microsoft.com/config/ubuntu/20.04/prod.list > /etc/apt/sources.list.d/mssql-release.list
exit

sudo apt update
sudo ACCEPT_EULA=Y apt install -y msodbcsql17
sudo ACCEPT_EULA=Y apt install -y mssql-tools
echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
source ~/.bashrc

# Install ODBC packages [5]
# - for OS
sudo apt install --install-suggests -y unixodbc unixodbc-dev
# - for R (run as R-script)
#> devtools::install_github("rstats-db/odbc")


# Set R package binaries source https://launchpad.net/~c2d4u.team/+archive/ubuntu/c2d4u4.0+
sudo add-apt-repository ppa:c2d4u.team/c2d4u4.0+
sudo apt update


# References ----
# 1. https://cran.r-project.org/
# 2. https://rstudio.com/products/rstudio/download-server/
# 3. https://db.rstudio.com/databases/microsoft-sql-server/
# 4. https://docs.microsoft.com/en-us/sql/connect/odbc/linux-mac/installing-the-microsoft-odbc-driver-for-sql-server?view=sql-server-ver15#ubuntu17
# 5. https://db.rstudio.com/best-practices/drivers/#linux-debian-ubuntu
# 5. https://db.rstudio.com/best-practices/drivers/
# 6. https://rtask.thinkr.fr/installation-of-r-4-0-on-ubuntu-20-04-lts-and-tips-for-spatial-packages/
