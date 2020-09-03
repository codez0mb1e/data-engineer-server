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

USER_NAME="<user_name>"; readonly USER_NAME 

apt install -y nodejs
nodejs -v

pip install --upgrade pip --user $USER_NAME
pip install jupyterlab --user $USER_NAME

jupyter lab --version
