#!/bin/bash

#
# Add user, configure Git and VSTS
#


adduser $usr

# NOTE: execute commands under new <user>
git config --global user.name "Dmitry Petukhov"
git config --global user.email "dpetukhov@***.com"
git config --list


ssh-keygen -C "dpetukhov@***.com"
cat ~/.ssh/id_rsa.pub


cd ~
mkdir apps
cd apps

git clone $repo_url


#
# References:
#   1. https://docs.microsoft.com/en-us/vsts/git/use-ssh-keys-to-authenticate?view=vsts