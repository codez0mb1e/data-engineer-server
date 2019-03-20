#!/bin/bash

#
# Install core libs and tools
#


# Install updates ----
apt update
apt list --upgradable
apt upgrade -y 


# Install core libs ----
apt install -y build-essential libssl-dev cmake


# Install tools ----
apt install -y htop
