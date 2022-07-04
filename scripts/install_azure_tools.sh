#!/bin/bash

#
# Install Azure CLI and Tools
#


# 0. Prepare ----
sudo apt update
sudo apt install -y ca-certificates curl apt-transport-https lsb-release gnupg


# 1. Install Azure CLI [1] ----

curl -sL https://packages.microsoft.com/keys/microsoft.asc |
    gpg --dearmor |
    sudo tee /etc/apt/trusted.gpg.d/microsoft.gpg > /dev/null

AZ_REPO=$(lsb_release -cs)
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" |
    sudo tee /etc/apt/sources.list.d/azure-cli.list


sudo apt update
sudo apt install -y azure-cli


# 2. Azure Core
pip install azure-identity


# 3. Azure Key Vault
pip install azure-keyvault-secrets

az ad sp create-for-rbac --name http://0xcode.in --skip-assignment
#> {
#>   "appId": "xxx",
#>   "displayName": "http://0xcode.in",
#>   "password": "****",
#>   "tenant": yyyy"
#> }

set KEY_VAULT_NAME="<key_vault_name>"
set AZURE_CLIENT_ID="<appId>"
az keyvault set-policy --name $KEY_VAULT_NAME --spn $AZURE_CLIENT_ID --key-permissions get list # other permissons: create update decrypt encrypt


# References ----
# 1. https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-linux?pivots=apt
