#!/bin/bash

#
# Install ML-frameworks and R tools
#


# Install updates ----
apt -y update
apt list --upgradable
apt -y upgrade


# Install harware drivers
./install_cuda_drivers.sh


# Install frameworks ----
# core libs
apt -y install build-essential libssl-dev cmake 


# Install tools ----
apt -y install htop
