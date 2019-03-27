#!/bin/bash

#
# Configure git
#


# Set params ----
USER_NAME="<user_name>"; readonly USER_NAME
USER_EMAIL="<user@email>"; readonly USER_EMAIL


# Config git
# WARN: execute commands under created RStudio Server user
git config --global user.name $USER_NAME
git config --global user.email $USER_EMAIL
git config --list

git config --global credential.helper 'cache --timeout=10000000'


# Set SSH key to github
ssh-keygen -C $USER_NAME
cat ~/.ssh/id_rsa.pub # copy output and add to SSH keys [2]


# Prepare to clone repos
mkdir ~/repos ; cd ~/repos

# Now you can clone repo:
# > git clone $repo_url


# References ----
# 1. https://happygitwithr.com/push-pull-github.html
# 2. https://github.com/settings/keys
