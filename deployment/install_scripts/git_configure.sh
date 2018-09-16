#!/bin/bash

#
# Add user, configure Git/VSTS
#

usr = "<user>"
userName = "<user_name>"
userEmail = "<user_email>"


adduser $usr

# NOTE: recommended execute commands under created $usr
git config --global user.name $userName
git config --global user.email $userEmail
git config --list


ssh-keygen -C $userName
cat ~/.ssh/id_rsa.pub


mkdir ~/apps ; cd ~/apps


# Now you can clone repo:
# git clone $repo_url


#
# References:
# 1. https://docs.microsoft.com/en-us/vsts/git/use-ssh-keys-to-authenticate?view=vsts
