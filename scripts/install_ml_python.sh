#!/bin/bash

#
# Install Python development tools
#


# Conda ----
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
sh Miniconda3-latest-Linux-x86_64.sh

conda update conda
conda --version

# get list of existing conda environments
conda env list

# config conda
conda config --add channels conda-forge
conda config --set channel_priority strict

# add new conda environment and install packages
$NEW_CONDA_ENV="<env_name>"; readonly $NEW_CONDA_ENV
conda create -n $NEW_CONDA_ENV python=3.8.8

conda install -n $NEW_CONDA_ENV scipy conda-tree # add required python packages here

# activate new environment
conda activate $NEW_CONDA_ENV

conda info
conda list
conda-tree whoneeds -t scipy

# export new environment
conda env export --no-builds > environment.yml
nano environment.yml


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
