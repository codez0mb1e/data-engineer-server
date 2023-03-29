#!/bin/bash

#
# Install CUDA drivers
#


# Set params ----
OS="ubuntu2004"; readonly OS
CUDNN_VERSION="8.2.2.*"
CUDA_VERSION="cuda11.4"


# Check hardware ----
lspci | grep -i NVIDIA


# Download and install the CUDA drivers ----
wget https://developer.download.nvidia.com/compute/cuda/repos/${OS}/x86_64/cuda-${OS}.pin

sudo mv cuda-${OS}.pin /etc/apt/preferences.d/cuda-repository-pin-600
sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/${OS}/x86_64/7fa2af80.pub
sudo add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/${OS}/x86_64/ /"

sudo apt-get update
sudo apt-get -y install cuda nvidia-cuda-toolkit


# Install cuDNN ----
sudo apt install libcudnn8=${CUDNN_VERSION}-1+${CUDA_VERSION}
sudo apt install libcudnn8-dev=${CUDNN_VERSION}-1+${CUDA_VERSION}

reboot


# Validate installation ----
cat /usr/local/cuda/version.json # or /usr/local/cuda/version.txt

nvcc -V
nvidia-smi


# References ----
# 1. https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&Distribution=Ubuntu&target_version=20.04&target_type=deb_network
# 2. https://www.tensorflow.org/install/gpu
# 3. https://docs.nvidia.com/deeplearning/cudnn/install-guide/index.html
