#!/bin/bash

#
# Install .NET 10 Development Tools
#

# 1. Install .NET 10 ----
# install
sudo apt install -y dotnet-sdk-10.0
sudo apt install -y aspnetcore-runtime-10.0

# validate
dotnet --info

# trust HTTPS dev certs (required for local web/API debugging)
dotnet dev-certs https --trust

# 2. Install VS Code extensions for .NET development ----
if command -v code &> /dev/null; then
  code --install-extension ms-dotnettools.csdevkit          # C# Dev Kit
  code --install-extension ms-dotnettools.csharp            # C# (OmniSharp/Roslyn)
  code --install-extension ms-dotnettools.vscode-dotnet-runtime
fi


# References ----
# 1. https://learn.microsoft.com/en-us/dotnet/core/install/linux-ubuntu-install?pivots=os-linux-ubuntu-2604&tabs=dotnet10
