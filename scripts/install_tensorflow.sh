#!/bin/bash

#
# Install Python, Tensorflow and Keras
#


# Install Python, pip, and virtualenv ----
python3 --version
pip3 --version
virtualenv --version

apt -y install python3-dev python3-pip
pip3 install -U virtualenv



# Install Tensorflow ---- 
# tensorflow-gpu cannot work with CUDA 10 [https://github.com/tensorflow/tensorflow/issues/22940]
pip3 install tf-nightly-gpu # tensorflow-gpu 

# validate installation 
python3 -c "import tensorflow as tf; print(tf.__version__)"



# Install Keras ----
# NOTE: before installing Keras, please install one of its backend engines: TensorFlow, Theano, or CNTK

# install a BLAS library to ensure that you can run fast tensor operations on your CPU [3]
apt -y install unzip pkg-config libopenblas-dev liblapack-dev

# install the Python scientific suite [3]
apt -y install python-numpy python-scipy python-matplotlib python-yaml

# install HDF5. It will allow you to save your Keras models to disk quickly and efficiently [3]
apt -y install libhdf5-serial-dev python-h5py

# install Keras
pip3 install keras

# validate installation
Rscript -e "library(keras); install_keras(tensorflow = 'gpu')"



# References ----
# 1. https://www.tensorflow.org/install/install_linux#NVIDIARequirements
# 2. https://keras.io/#installation
# 3. https://livebook.manning.com/#!/book/deep-learning-with-r/appendix-a/1
