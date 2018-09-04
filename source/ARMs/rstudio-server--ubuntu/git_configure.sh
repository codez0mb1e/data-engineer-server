#!/bin/bash

#
# Add user, configure Git and VSTS
#



usr=$1
adduser $usr

# NOTE: execute commands under new <user>
mkdir apps
cd apps

git config --global user.name "Dmitry Petukhov"
git config --global user.email "dpetukhov@***.com"
git config --list


# See more: https://docs.microsoft.com/en-us/vsts/git/use-ssh-keys-to-authenticate?view=vsts
ssh-keygen -C "dpetukhov@***.com"
cat /home/$usr/.ssh/id_rsa.pub

git clone ssh://<server>@vs-ssh.visualstudio.com:22/DefaultCollection/_ssh/<repo>


# kaggle tools