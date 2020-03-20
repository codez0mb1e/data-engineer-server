#!/bin/bash

#
# Install .NET Core 3.1
#


wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
dpkg -i packages-microsoft-prod.deb


add-apt-repository universe
apt update

apt install apt-transport-https
apt update

apt install dotnet-runtime-3.1


# Validate
dotnet new console
dotnet run


# References ----
# 1. https://docs.microsoft.com/ru-ru/dotnet/core/install/linux-package-manager-ubuntu-1804
