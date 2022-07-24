#!/bin/bash

#
# Install .NET and Powershell Core
#


# 0. Prepare ----

# Download and register Microsoft repository GPG keys
wget -q "https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb" -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb


# 1. Install .NET 6 ----

# Install
sudo apt install -y dotnet-sdk-6.0

# Validate
mkdir hello_dotnet && cd hello_dotnet

dotnet new console
dotnet run

rm hello_dotnet


# 2. PowerShell Core ----

# Install
sudo apt install -y powershell

# Validate
pwsh


# References ----
# 1. https://docs.microsoft.com/en-us/dotnet/core/install/linux-ubuntu
# 2. https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-core-on-linux?view=powershell-7.1
