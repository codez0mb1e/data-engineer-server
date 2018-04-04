#!/bin/bash

# get args
usr=$1
password=$2

# install last updates
apt-get -y update
apt-get -y upgrade

