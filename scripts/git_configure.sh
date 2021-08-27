#!/bin/bash

#
# Configure git
#


# Set params ----
USER_NAME="<name>"; readonly USER_NAME
USER_EMAIL="<email>"; readonly USER_EMAIL


# Config git ----
# WARN: execute commands under created RStudio Server user
git config --global user.name $USER_NAME
git config --global user.email $USER_EMAIL
git config --global credential.helper 'cache --timeout=10000000'

git config --list


# Set SSH key to github ----
ls -l ~/.ssh/id_*.pub
ssh-keygen -C $USER_NAME
cat ~/.ssh/id_rsa.pub # copy output and add to SSH keys [2]


# Prepare to clone repos ----
mkdir ~/repos ; cd ~/repos

# Now you can clone repo (for example this repo):
git clone git@github.com:codez0mb1e/cloud-rstudio-server.git


# References ----
# 1. https://happygitwithr.com/push-pull-github.html
# 2. https://github.com/settings/keys
