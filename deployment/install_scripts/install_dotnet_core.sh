#!/bin/bash

#
# Install .NET Core 2.2
#


wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb
dpkg -i packages-microsoft-prod.deb

apt update
apt -y install dotnet-runtime-2.2


# References ----
# 1. https://dotnet.microsoft.com/download/linux-package-manager/ubuntu18-04/runtime-current
