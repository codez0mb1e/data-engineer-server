
#!/bin/bash

#
# Install CUDA drivers
#


# Check hardware
lspci | grep -i NVIDIA


# Download and install the CUDA drivers
CUDA_REPO_PATH=http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64
CUDA_REPO_PKG=cuda-repo-ubuntu1804_10.0.130-1_amd64.deb

sudo apt-key adv --fetch-keys ${CUDA_REPO_PATH}/7fa2af80.pub 

wget -O /tmp/${CUDA_REPO_PKG} ${CUDA_REPO_PATH}/${CUDA_REPO_PKG} 
sudo dpkg -i /tmp/${CUDA_REPO_PKG}
rm -f /tmp/${CUDA_REPO_PKG}

wget http://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64/nvidia-machine-learning-repo-ubuntu1804_1.0.0-1_amd64.deb
sudo apt install ./nvidia-machine-learning-repo-ubuntu1804_1.0.0-1_amd64.deb


sudo apt-get -y update
sudo apt-get -y install cuda-drivers
sudo apt-get -y install cuda


#! WARN: need to reboot
sudo reboot


# Validate installation
nvidia-smi
