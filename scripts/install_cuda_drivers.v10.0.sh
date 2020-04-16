#!/bin/bash

#
# Install CUDA drivers v10.0
#


# Set params ----
OS="ubuntu1804"; readonly OS


# Check hardware ----
lspci | grep -i NVIDIA


# Download and install the CUDA drivers ----

# Add NVIDIA package repositories
wget https://developer.download.nvidia.com/compute/cuda/repos/${OS}/x86_64/cuda-repo-${OS}_10.0.130-1_amd64.deb

dpkg -i cuda-repo-${OS}_10.0.130-1_amd64.deb
apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/${OS}/x86_64/7fa2af80.pub

apt update

wget http://developer.download.nvidia.com/compute/machine-learning/repos/${OS}/x86_64/nvidia-machine-learning-repo-${OS}_1.0.0-1_amd64.deb

apt install -y ./nvidia-machine-learning-repo-${OS}_1.0.0-1_amd64.deb
apt update

# Install NVIDIA driver
apt install -y --no-install-recommends nvidia-driver-410

# Reboot
reboot

# Validate installation
cat /usr/local/cuda/version.txt
nvidia-smi


# Install development and runtime libraries (~4GB)
apt install -y --no-install-recommends \
    cuda-10-0 \
    libcudnn7=7.4.1.5-1+cuda10.0 \
    libcudnn7-dev=7.4.1.5-1+cuda10.0
apt update


# Install TensorRT. Requires that libcudnn7 is installed above.
apt install -y nvinfer-runtime-trt-repo-ubuntu1804-5.0.2-ga-cuda10.0
apt update

apt install -y --no-install-recommends libnvinfer-dev=5.0.2-1+cuda10.0



# References ----
# 1. https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&target_distro=Ubuntu&target_version=1604&target_type=debnetwork
# 2. https://www.tensorflow.org/install/gpu
