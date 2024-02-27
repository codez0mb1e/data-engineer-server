#!/bin/bash

#
# Install .NET and Powershell Core
#


# 0. Prepare ----

# Download and register Microsoft repository GPG keys
wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb

# 1. Install .NET 8 ----

# Install
sudo apt-get update && \
  sudo apt-get install -y dotnet-sdk-8.0

# Validate
dotnet --version



# 2. PowerShell Core ----

# Install
sudo apt install -y powershell

# Validate
pwsh


# References ----
# 1. https://docs.microsoft.com/en-us/dotnet/core/install/linux-ubuntu
# 2. https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-core-on-linux?view=powershell-7.1
