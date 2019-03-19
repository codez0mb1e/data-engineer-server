#!/bin/bash

#
# Add user, configure Git/VSTS
#


# WARN: execute commands under created RStudio Server user


# Set params ----
USER_NAME="<user_name>"; readonly USER_NAME
USER_EMAIL="<user@email>"; readonly USER_EMAIL


git config --global user.name $USER_NAME
git config --global user.email $USER_EMAIL
git config --list


ssh-keygen -C $USER_NAME
cat ~/.ssh/id_rsa.pub # copy output and add to SSH keys https://github.com/settings/keys


mkdir ~/apps ; cd ~/apps


# Now you can clone repo:
git clone $repo_url



# References ----
# 1. https://docs.microsoft.com/en-us/vsts/git/use-ssh-keys-to-authenticate?view=vsts
