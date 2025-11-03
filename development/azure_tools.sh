#!/bin/bash

#
# Install Azure CLI and Tools
#


# 0. Prepare [1] ----
sudo mkdir -p /etc/apt/keyrings
curl -sLS https://packages.microsoft.com/keys/microsoft.asc |
  sudo gpg --dearmor -o /etc/apt/keyrings/microsoft.gpg
sudo chmod go+r /etc/apt/keyrings/microsoft.gpg

curl -sL https://packages.microsoft.com/keys/microsoft.asc |
    gpg --dearmor |
    sudo tee /etc/apt/trusted.gpg.d/microsoft.gpg > /dev/null

AZ_REPO=$(lsb_release -cs)

echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" |
    sudo tee /etc/apt/sources.list.d/azure-cli.list


# 1. Install Azure CLI ----
sudo apt update
sudo apt install -y azure-cli

az version


# 2. Azure Core ----
pip install azure-identity
az login --use-device-code

az account set --subscription <subscription_name>


# 3. Azure Key Vault ----
# install
pip install azure-keyvault-secrets

# set up permissions
APP_ID="<application_id>"; readonly APP_ID
KEY_VAULT_NAME="<key_vault_name>"; readonly KEY_VAULT_NAME
AZURE_CLIENT_ID="<appId>"; readonly AZURE_CLIENT_ID

az ad sp create-for-rbac --name $APP_ID --skip-assignment
#> {
#>   "appId": "<application_id>",
#>   "displayName": "Cloud deep learning server",
#>   "password": "****",
#>   "tenant": "<tenant_id>"
#> }

az keyvault set-policy --name $KEY_VAULT_NAME --spn $AZURE_CLIENT_ID --key-permissions get list # other permissons: create update decrypt encrypt

# validate
az keyvault secret list --vault-name $KEY_VAULT_NAME


# 4. Azure ACR
az acr list
az acr login -n <registry_name>


# References ----
# 1. https://learn.microsoft.com/en-us/cli/azure/install-azure-cli-linux?pivots=apt
