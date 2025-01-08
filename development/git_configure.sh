#!/bin/bash

#
# Configure git and GPG signature
#


# 0. Set params ----
USER_NAME="<name>"; readonly USER_NAME
USER_EMAIL="<email>"; readonly USER_EMAIL


# 1. Config git ----
git --version

git config --global user.name $USER_NAME
git config --global user.email $USER_EMAIL
git config --global credential.helper 'cache --timeout=3600' # cache password for 1 hour

git config --list


# 2. Set SSH key to github ----
# Generate SSH key (see unbuntu-os/README.md#new-ssh-key)
# register public keys [2]


# 3. Validate ----
# Prepare to clone repos
mkdir ~/apps && cd ~/apps

# Now you can clone repo (for example this repo):
git clone git@github.com:codez0mb1e/data-engineer-server.git


# 3. Commit signature verification [4] ----
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


# References ----
# 1. https://happygitwithr.com/push-pull-github.html
# 2. https://github.com/settings/keys
# 3. https://superuser.com/questions/215504/permissions-on-private-key-in-ssh-folder
# 4. https://docs.github.com/en/authentication/managing-commit-signature-verification/about-commit-signature-verification
