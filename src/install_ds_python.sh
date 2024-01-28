#!/bin/bash

#
# Install Python development tools
#


# 0. Set up python dev, pip, and virtualenv ----
sudo apt install -y python3-dev python3-pip python3-virtualenv
# or if already installed
pip install --upgrade pip

python3 -V
pip -V
virtualenv -V


# 1. Set up Conda ----
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
sh Miniconda3-latest-Linux-x86_64.sh

conda update conda
conda -V

# config conda
conda config --add channels conda-forge
#conda config --add channels "Microsoft"
conda config --set channel_priority strict


# 2. Set up DS environment ----
NEW_CONDA_ENV="<your_data_science_env>"; readonly NEW_CONDA_ENV
PYTHON_VERSION=3.10; readonly PYTHON_VERSION

conda create -n $NEW_CONDA_ENV python=$PYTHON_VERSION
conda env list

# activate new environment
conda activate $NEW_CONDA_ENV
conda info

# install dev tools
cat requirements.dev.txt
pip install --upgrade -r requirements.dev.txt

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
