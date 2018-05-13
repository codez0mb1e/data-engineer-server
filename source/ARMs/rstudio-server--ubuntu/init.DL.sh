#!/bin/bash

### summary: install DL-frameworks

## install updates ----
apt-get -y update
apt-get -y dist-upgrade


## install Tensorflow ----
# install, create, and activate Virtualenv [3]
apt-get -y install python3-pip python3-dev python-virtualenv
virtualenv --system-site-packages -p python3 ~/tensorflow
source ~/tensorflow/bin/activate

# ensure pip ≥8.1 is installed [3]
easy_install -U pip

# install TensorFlow in the active Virtualenv environment [3]
pip3 install --upgrade tensorflow-gpu


## install Keras ----
# install a BLAS library to ensure that you can run fast tensor operations on your CPU [1]
apt-get -y install unzip pkg-config libopenblas-dev liblapack-dev

# install the Python scientific suite [1]
apt-get -y install python-numpy python-scipy python-matplotlib python-yaml

# install HDF5. This library, originally developed by NASA, stores large files of numeric
# data in an efficient binary format. It will allow you to save your Keras models to disk
# quickly and efficiently [1]
apt-get -y install libhdf5-serial-dev python-h5py

# install Keras from PyPI [2]
pip install keras #? pip3 
# or for upgrade existing [2]
pip install keras --upgrade pip #? pip3 


## install CNTK (todo: section needs to be checked) ----
apt-get -y install libopencv-dev python-opencv

wget https://repo.continuum.io/archive/Anaconda3-5.1.0-Linux-x86_64.sh
sh Anaconda3-5.1.0-Linux-x86_64.sh

# source: https://microsoft.github.io/CNTK-R//articles/installation.html
conda create -n cntk-py36 python=3.6 anaconda
source activate cntk-py36

# full list of wheels https://github.com/Microsoft/CNTK/blob/master/README.md
pip install https://cntk.ai/PythonWheel/CPU-Only/cntk-2.3.1-cp36-cp36m-linux_x86_64.whl # https://cntk.ai/PythonWheel/GPU/cntk-2.3.1-cp36-cp36m-linux_x86_64.whl

R
> Sys.setenv(RETICULATE_PYTHON="/home/dp/anaconda3/envs/cntk-py36/bin/python")
> reticulate::py_module_available("cntk")


## References: ----
# [1] Deep_Learning_with_R_v1_MEAP
# [2] https://keras.io/#installation
# [3] https://www.tensorflow.org/install/install_linux

