#!/bin/bash

#
# Install ML-frameworks and R tools
#


# Install updates ----
apt-get -y update &&
apt-get -y dist-upgrade


# Install core libs ----
apt-get -y install build-essential libssl-dev cmake 


# Execute scripts:
ls
./install_tensorflow.sh

adduser <username>
./install_r.sh
./git_configure.sh
./install_lightgbm.sh


# Install tools ----
apt-get -y install htop
