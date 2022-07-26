#!/bin/bash

#
# Install Azure CLI and Tools
#


# 0. Prepare ----

curl -sL https://packages.microsoft.com/keys/microsoft.asc |
    gpg --dearmor |
    sudo tee /etc/apt/trusted.gpg.d/microsoft.gpg > /dev/null

AZ_REPO=$(lsb_release -cs)

echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" |
    sudo tee /etc/apt/sources.list.d/azure-cli.list


# 1. Install Azure CLI [1] ----

sudo apt update
sudo apt install -y azure-cli

az version


# 2. Azure Core ----
pip install azure-identity
az login


# 3. Azure Key Vault ----
# install
pip install azure-keyvault-secrets

# set up permissions
APP_ID="<application_id>"; readonly APP_ID
KEY_VAULT_NAME="<key_vault_name>"; readonly KEY_VAULT_NAME
AZURE_CLIENT_ID="<appId>"; readonly AZURE_CLIENT_ID

az ad sp create-for-rbac --name $APP_ID --skip-assignment
#> {
#>   "appId": "xxx",
#>   "displayName": "http://0xcode.in",
#>   "password": "****",
#>   "tenant": yyyy"
#> }

az keyvault set-policy --name $KEY_VAULT_NAME --spn $AZURE_CLIENT_ID --key-permissions get list # other permissons: create update decrypt encrypt

# validate
az keyvault list --vault-name $KEY_VAULT_NAME



# References ----
# 1. https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-linux?pivots=apt
