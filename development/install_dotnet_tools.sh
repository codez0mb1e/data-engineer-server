#!/bin/bash

#
# Install .NET
#

# 1. Install .NET 8 ----
# install
sudo apt install -y dotnet-sdk-8.0
# validate
dotnet --info


# References ----
# 1. https://learn.microsoft.com/en-us/dotnet/core/install/linux-ubuntu-install?pivots=os-linux-ubuntu-2404&tabs=dotnet8
