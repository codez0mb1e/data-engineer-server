#!/bin/bash

#
# Install Python development tools
#


# Core libs ----

python -V
python3 -V

alias python=python3


# apt install python3-tk


# Jupyter lab ----

$USR="<user_name>"; readonly $USR 

apt install -y nodejs
nodejs -v

pip install --upgrade pip --user $USR
pip install jupyterlab --user $USR

jupyter lab --version
