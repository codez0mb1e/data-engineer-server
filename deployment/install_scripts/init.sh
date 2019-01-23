#!/bin/bash

#
# Install ML-frameworks and R tools
#


# Install updates ----
apt-get -y update &&
apt-get -y dist-upgrade


# Install harware drivers
./install_cuda_drivers.sh


# Install frameworks ----
# core libs
apt-get -y install build-essential libssl-dev cmake 

ls
./install_tensorflow.sh
./install_r.sh
./git_configure.sh
./install_lightgbm.sh


# Install tools ----
apt-get -y install htop
