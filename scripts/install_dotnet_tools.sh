#!/bin/bash

#
# Install .NET 5.0 and Powershell Core
#


# Prepare ----

# Download and register Microsoft repository GPG keys
wget https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
dpkg -i packages-microsoft-prod.deb

apt install -y wget apt-transport-https software-properties-common
apt update


# .NET 5.0 ----

# Install
apt install -y dotnet-sdk-5.0

# Validate
dotnet new console
dotnet run


# PowerShell Core ----

# Enable the "universe" repositories
add-apt-repository universe

# Install
apt install -y powershell

# Validate
pwsh


# References ----
# 1. https://docs.microsoft.com/en-us/dotnet/core/install/linux-ubuntu#1804-
# 2. https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-core-on-linux?view=powershell-7.1
