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

curl -fsSL https://deb.nodesource.com/setup_15.x | sudo -E bash -
apt install -y nodejs

nodejs -v

pip install jupyterlab --user $USR
jupyter lab --version

pip install ipywidgets
jupyter labextension install @jupyter-widgets/jupyterlab-manager



# Azure ML ----

pip install azureml-sdk



# References ----

# 1. https://docs.conda.io/projects/conda/en/latest/user-guide/install/linux.html
