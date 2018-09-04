#!/bin/bash

#
# Install CUDA, Python, Tensorflow and Keras
#



# Install CUDA ----
# See also:
#   - https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&target_distro=Ubuntu&target_version=1604&target_type=debnetwork
#   - https://www.tensorflow.org/install/install_linux#NVIDIARequirements

# Adds NVIDIA package repository
apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub
wget http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_9.1.85-1_amd64.deb
wget http://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1604/x86_64/nvidia-machine-learning-repo-ubuntu1604_1.0.0-1_amd64.deb

dpkg -i cuda-repo-ubuntu1604_9.1.85-1_amd64.deb
dpkg -i nvidia-machine-learning-repo-ubuntu1604_1.0.0-1_amd64.deb
apt-get update

# Includes optional NCCL 2.x.
apt-get -y install cuda9.0 cuda-cublas-9-0 cuda-cufft-9-0 cuda-curand-9-0 \
  cuda-cusolver-9-0 cuda-cusparse-9-0 libcudnn7=7.1.4.18-1+cuda9.0 \
  libnccl2=2.2.13-1+cuda9.0 cuda-command-line-tools-9-0
  
# Install TensorRT runtime, must be done after above cuda install (optionally)
sudo apt-get update
sudo apt-get -y install libnvinfer4=4.1.2-1+cuda9.0

# Install GPU tools (optionally)
apt-get -y install nvidia-smi



# Install Python, pip, and virtualenv ----
python3 -V  # or: python -V
pip3 -V     # or: pip -V

apt-get -y  install python3-pip python3-dev python-virtualenv
pip install -U pip

# Create virtual environment
mkdir ~/tensorflow
cd ~/tensorflow

virtualenv --system-site-packages -p python3 venv

# Activate virtualenv
source ~/tensorflow/venv/bin/activate

# ensure pip ≥8.1 is installed
pip install -U pip # or: easy_install -U pip



# Install Tensorflow ---- 
pip install -U tensorflow-gpu #? pip3

# Validate installation
python -c "import tensorflow as tf; print(tf.__version__)"



# Install Keras ----
# See also:
#  1. https://keras.io/#installation
#  2. Deep_Learning_with_R_v1_MEAP

# install a BLAS library to ensure that you can run fast tensor operations on your CPU [2]
apt-get -y install unzip pkg-config libopenblas-dev liblapack-dev

# install the Python scientific suite [2]
apt-get -y install python-numpy python-scipy python-matplotlib python-yaml

# install HDF5. This library, originally developed by NASA, stores large files of numeric
# data in an efficient binary format. It will allow you to save your Keras models to disk
# quickly and efficiently [2]
apt-get -y install libhdf5-serial-dev python-h5py


# install Keras]
pip3 install keras


# R:
#  library(keras)
#  install_keras(tensorflow = "gpu")
