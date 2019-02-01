#!/bin/bash

#
# Install CUDA drivers
#

# TODO: move to cuda9

# Set params ----
OS="ubuntu1804"
readonly USR


# Check hardware ----
lspci | grep -i NVIDIA


# Download and install the CUDA drivers ----
apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/${OS}/x86_64/7fa2af80.pub

wget http://developer.download.nvidia.com/compute/cuda/repos/${OS}/x86_64/cuda-repo-${OS}_10.0.130-1_amd64.deb
apt -y install ./cuda-repo-${OS}_10.0.130-1_amd64.deb

wget http://developer.download.nvidia.com/compute/machine-learning/repos/${OS}/x86_64/nvidia-machine-learning-repo-${OS}_1.0.0-1_amd64.deb
apt -y install ./nvidia-machine-learning-repo-${OS}_1.0.0-1_amd64.deb

apt -y update

apt -y install cuda-drivers cuda10.0
apt -y install cuda-cublas-10-0 cuda-cufft-10-0 cuda-curand-10-0 cuda-cusolver-10-0 cuda-cusparse-10-0 cuda-command-line-tools-10-0
apt -y install libcudnn7 libnccl2

reboot


# Validate installation ----
nvidia-smi


# References ----
# 1. https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&target_distro=Ubuntu&target_version=1604&target_type=debnetwork
# 2. https://www.tensorflow.org/install/gpu
