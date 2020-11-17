#!/bin/bash

#
# Install Python development tools
#


# Core libs ----

python -V
python3 -V

alias python=python3 #! WARN: may be it is not the best idea


# Conda ----

wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
sh Miniconda3-latest-Linux-x86_64.sh

conda update -n base conda
conda update conda

conda info
conda list



# Jupyter lab ----

$USR="<user_name>"; readonly $USR 

apt install -y nodejs
nodejs -v

pip install jupyterlab --user $USR

jupyter lab --version


# References
#
# 1. https://docs.conda.io/projects/conda/en/latest/user-guide/install/linux.html
#
