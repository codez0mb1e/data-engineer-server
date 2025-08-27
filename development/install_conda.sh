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


# 1. Set up Conda [2] ----
# Detect OS and architecture
OS_NAME="$(uname -s)"
ARCH_NAME="$(uname -m)"

if [[ "$OS_NAME" == "Darwin" && "$ARCH_NAME" == "arm64" ]]; then
    echo "Detected macOS (Apple Silicon). Installing Miniconda for arm64..."
    curl -fsSLo ~/miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-arm64.sh
    bash ~/miniconda.sh -b -p $HOME/miniconda
    $HOME/miniconda/bin/conda init zsh
    rm ~/miniconda.sh
elif [[ "$OS_NAME" == "Linux" ]]; then
    echo "Detected Linux. Installing Miniconda for x86_64..."
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh
    bash ~/miniconda.sh -b -p $HOME/miniconda
    $HOME/miniconda/bin/conda init bash
    rm ~/miniconda.sh
else
    echo "Unsupported OS or architecture: $OS_NAME $ARCH_NAME"
    exit 1
fi

# validate
conda --version

# config conda and channels
conda config --set always_yes true
conda config --set env_prompt '[{name}]'
conda config --set pip_interop_enabled true
conda config --set auto_activate_base false
conda config --set show_channel_urls true
conda config --set channel_priority strict

# Prioritize conda-forge for latest DS packages
conda config --remove-key channels || true  # Remove all channels to reset priority
conda config --add channels conda-forge
conda config --add channels defaults
conda config --add channels bioconda
conda config --add channels Microsoft

# show all configs
conda config --show


# 2. Set up DS environment ----
NEW_ENV="<env_name>"; readonly NEW_ENV
PYTHON_VERSION=3.13; readonly PYTHON_VERSION

# Create environment  -- with common DS tools (uncomment if needed)
conda create -n $NEW_ENV python=$PYTHON_VERSION # numpy pandas scipy scikit-learn matplotlib seaborn jupyterlab ipykernel
conda env list

# activate new environment
conda activate $NEW_ENV
conda info

# install dev tools
cat requirements-dev.txt
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

# remove conda env
conda remove -n $NEW_ENV -all


# 4. Linting ----
pip install pylint


# References ----
# 1. https://docs.conda.io/projects/conda/en/latest/user-guide/install/linux.html
# 2. https://docs.anaconda.com/free/miniconda/
