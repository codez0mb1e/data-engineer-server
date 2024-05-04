#!/bin/bash

#
# Install Python development tools
#


# 0. Set up python dev, pip, and virtualenv ----
sudo apt install -y python3-dev python3-pip python3-virtualenv
# or if already installed
pip install --upgrade pip

python3 --version
pip --version
virtualenv --version


# 1. Set up Conda ----
# install [2]
mkdir -p ~/miniconda3
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3

~/miniconda3/bin/conda init bash

# validate
conda update conda
conda --version

# config conda and channels
conda config --set auto_activate_base false

conda config --add channels defaults
conda config --add channels bioconda
conda config --add channels conda-forge
conda config --add channels Microsoft # if you like Azure :)

conda config --set show_channel_urls true
conda config --set channel_priority flexible

# show all configs
conda config --show


# 2. Set up DS environment ----
NEW_ENV="nrmln_py12"; readonly NEW_ENV
PYTHON_VERSION=3.12; readonly PYTHON_VERSION

conda create -n $NEW_ENV python=$PYTHON_VERSION
conda env list

# activate new environment
conda activate $NEW_ENV
conda info

# install dev tools
cat requirements.dev.txt
pip install --upgrade -r requirements-dev.txt

# install DS tools
cat requirements.txt
pip install --upgrade -r requirements.txt

conda list

# export new environment
conda env export --no-builds > environment.yml
nano environment.yml


# 3. Set up updates ----
conda update -n base conda
conda update --all --yes
pip install --upgrade pip


# 4. Linting ----
pip install pylint


# References ----
# 1. https://docs.conda.io/projects/conda/en/latest/user-guide/install/linux.html
# 2. https://docs.anaconda.com/free/miniconda/
