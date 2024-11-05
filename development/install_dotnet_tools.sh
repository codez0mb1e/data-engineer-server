#!/bin/bash

#
# Install .NET
#


# 0. Prepare ----
# download and register Microsoft repository GPG keys (WARN: use only for Ubuntu 20.04)
wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb

# 1. Install .NET 8 ----
# install
sudo apt-get update && \
  sudo apt-get install -y dotnet-sdk-8.0
# validate
dotnet --version


# References ----
# 1. https://docs.microsoft.com/en-us/dotnet/core/install/linux-ubuntu
# 2. https://learn.microsoft.com/en-us/dotnet/core/install/linux-ubuntu-install?pivots=os-linux-ubuntu-2404&tabs=dotnet8
