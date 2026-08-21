#!/bin/bash

#
# Configure git and GPG signature
#


# 0. Set params ----
USER_NAME="<name>"; readonly USER_NAME
USER_EMAIL="<email>"; readonly USER_EMAIL


# 1. Config git ----
git --version

git config --global user.name "$USER_NAME"
git config --global user.email "$USER_EMAIL"
git config --global credential.helper 'cache --timeout=3600' # (optional) cache password for 1 hour

git config --list


# 2. Set SSH key to github ----
# generate new if necessary
ssh-keygen -t ed25519 -C "$USER_NAME"
# add to ssh-agent
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
# get pubkey and register https://github.com/settings/ssh/new [2]
cat ~/.ssh/id_ed25519.pub
# test connection
ssh -T git@github.com


# 3. GitHub CLI ----
# install
sudo apt install -y gh 
# check
gh --version
# auth
gh auth login --web

# clone smth (for example this repo)
mkdir ~/apps && cd ~/apps
gh repo clone codez0mb1e/data-engineer-server


# 4. Commit signature verification [4] ----
# check GPG version
gpg --version # should be >=2.1

# generate GPG key
gpg --full-generate-key 
# or import existing
gpg --list-secret-keys --keyid-format=long
# validate
echo "test" | gpg --clearsign | gpg --verify

# Export public key
# Open https://github.com/settings/gpg/new and paste you GPG key id from:
# (use second part of "sec" as gpg_key_id)
gpg --armor --export <gpg_key_id>

# Configure git to use GPG key
git config --global user.signingkey <gpg_key_id>
git config --global commit.gpgsign true

[ -f ~/.bashrc ] && echo 'export GPG_TTY=$(tty)' >> ~/.bashrc

# cache GPG passphrase for 1 hour
mkdir -p ~/.gnupg
touch ~/.gnupg/gpg-agent.conf
grep -qxF "default-cache-ttl 3600" ~/.gnupg/gpg-agent.conf || echo "default-cache-ttl 3600" >> ~/.gnupg/gpg-agent.conf
grep -qxF "max-cache-ttl 86400" ~/.gnupg/gpg-agent.conf || echo "max-cache-ttl 86400" >> ~/.gnupg/gpg-agent.conf
gpgconf --reload gpg-agent

# (optional) if you have issues with gpg
# sudo install -d -m 755 /etc/gnupg && sudo touch /etc/gnupg/gpgconf.conf
gpgconf --check-config

# create alias to test gpg signature 
grep -q "alias signme=" ~/.bashrc || echo "alias signme='echo \"test\" | gpg --clearsign | gpg --verify'" >> ~/.bashrc


# References ----
# 1. https://happygitwithr.com/push-pull-github.html
# 2. https://github.com/settings/keys
# 3. https://superuser.com/questions/215504/permissions-on-private-key-in-ssh-folder
# 4. https://docs.github.com/en/authentication/managing-commit-signature-verification/about-commit-signature-verification
