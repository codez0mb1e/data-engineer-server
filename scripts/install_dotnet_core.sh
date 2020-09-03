#!/bin/bash

#
# Install .NET Core 3.1 and Powershell Core
#


# .NET Core ----

# 1. Download 

# Download Microsoft repository GPG keys
wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb
# Register the Microsoft repository GPG keys
dpkg -i packages-microsoft-prod.deb


# 2. Install
apt update
apt install -y apt-transport-https

apt update
apt install -y dotnet-sdk-3.1


# 3. Validate
dotnet new console
dotnet run


# PowerShell Core ----

# 1. Enable the "universe" repositories
add-apt-repository universe

# 2. Install
apt install -y powershell

# 3. Validate
pwsh


# References ----
# 1. https://docs.microsoft.com/en-us/dotnet/core/install/linux-ubuntu#1804-
# 2. https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-core-on-linux?view=powershell-7#installation-via-package-repository---ubuntu-1804
