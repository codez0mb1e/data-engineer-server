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
# check GPG version (Ubuntu 26.04 ships GnuPG >=2.4)
gpg --version

# headless server: no GUI/X11, so gpg-agent needs a curses pinentry instead of the default graphical one
sudo apt update && sudo apt install -y pinentry-curses
mkdir -p ~/.gnupg && chmod 700 ~/.gnupg
touch ~/.gnupg/gpg-agent.conf
grep -qxF "pinentry-program $(command -v pinentry-curses)" ~/.gnupg/gpg-agent.conf \
  || echo "pinentry-program $(command -v pinentry-curses)" >> ~/.gnupg/gpg-agent.conf

# GPG_TTY must be set before pinentry is invoked over SSH
export GPG_TTY=$(tty)
[ -f ~/.bashrc ] && ! grep -qxF 'export GPG_TTY=$(tty)' ~/.bashrc && echo 'export GPG_TTY=$(tty)' >> ~/.bashrc
gpgconf --reload gpg-agent

# generate GPG key (prefer ECC/ed25519 with an expiration date over default RSA)
gpg --full-generate-key 
# or non-interactively: usage MUST include "sign" (bare "cert" makes a certify-only key git can't sign with)
# 0 means never expires, or use 1y/2y/5y for expiration
gpg --quick-generate-key "$USER_NAME <$USER_EMAIL>" ed25519 default 0
# or import existing
gpg --list-secret-keys --keyid-format=long
# validate
echo "0xDECAF" | gpg --clearsign | gpg --verify

# extract the long key id of the key matching USER_EMAIL (parses machine-readable --with-colons output)
GPG_KEY_ID=$(gpg --list-secret-keys --keyid-format=long --with-colons "$USER_EMAIL" | awk -F: '/^sec:/{print $5; exit}')
echo "$GPG_KEY_ID"

# Export public key
# Open https://github.com/settings/gpg/new and paste your GPG key id from:
gpg --armor --export "$GPG_KEY_ID"

# Configure git to use GPG key
git config --global gpg.program "$(command -v gpg)"
git config --global user.signingkey "$GPG_KEY_ID"
git config --global commit.gpgsign true
git config --global tag.gpgsign true

# cache GPG passphrase (max 24h) - shorten max-cache-ttl on shared/less-trusted servers
grep -qxF "default-cache-ttl 3600" ~/.gnupg/gpg-agent.conf || echo "default-cache-ttl 3600" >> ~/.gnupg/gpg-agent.conf
grep -qxF "max-cache-ttl 86400" ~/.gnupg/gpg-agent.conf || echo "max-cache-ttl 86400" >> ~/.gnupg/gpg-agent.conf
gpgconf --reload gpg-agent

# (optional) if you have issues with gpg
# sudo install -d -m 755 /etc/gnupg && sudo touch /etc/gnupg/gpgconf.conf
gpgconf --check-programs

# create alias to test gpg signature 
grep -q "alias signme=" ~/.bashrc || echo "alias signme='echo \"signme\" | gpg --clearsign | gpg --verify'" >> ~/.bashrc

# end-to-end test: confirm git itself produces and recognizes a signed commit
# git commit --allow-empty -S -m "test signed commit" && git log --show-signature -1


# References ----
# 1. https://happygitwithr.com/push-pull-github.html
# 2. https://github.com/settings/keys
# 3. https://superuser.com/questions/215504/permissions-on-private-key-in-ssh-folder
# 4. https://docs.github.com/en/authentication/managing-commit-signature-verification/about-commit-signature-verification
