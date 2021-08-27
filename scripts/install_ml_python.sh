#!/bin/bash

#
# Install Python development tools
#


# Conda ----
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
sh Miniconda3-latest-Linux-x86_64.sh

conda update conda
conda --version


# Jupyter lab ----
$USR="<user_name>"; readonly $USR 

curl -fsSL https://deb.nodesource.com/setup_15.x | sudo -E bash -
apt install -y nodejs

nodejs -v

pip install jupyterlab --user $USR
jupyter lab --version

pip install ipywidgets
jupyter labextension install @jupyter-widgets/jupyterlab-manager


# Install packages ----
cat requirements.txt
pip install -r requirements.txt


# References ----

# 1. https://docs.conda.io/projects/conda/en/latest/user-guide/install/linux.html
