#!/bin/bash

#
# Install .NET
#

# 1. Install .NET 9 ----
# install
sudo add-apt-repository ppa:dotnet/backports
sudo apt-get update && \
  sudo apt-get install -y dotnet-sdk-9.0
# validate
dotnet --info


# References ----
# 1. https://learn.microsoft.com/en-us/dotnet/core/install/linux-ubuntu-install?pivots=os-linux-ubuntu-2404&tabs=dotnet9
