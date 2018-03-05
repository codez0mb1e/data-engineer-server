#!/bin/bash

## Get params
usr=$1
password=$2


## Install last updates
apt-get -y update
apt-get -y upgrade
apt-get -y dist-upgrade


# tools
apt-get -y install htop
