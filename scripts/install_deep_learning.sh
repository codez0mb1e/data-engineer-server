#!/bin/bash

#
# Install Tensorflow and Keras
#

# TODO: python3 -> python, pip3 -> pip

# Install Python, pip, and virtualenv ----
python3 --version
pip3 --version
virtualenv --version

apt install -y python3-dev python3-pip
pip3 install -U virtualenv



# Install Tensorflow ---- 
pip3 install --upgrade tensorflow-gpu

# validate installation 
python3 -c "import tensorflow as tf; tf.enable_eager_execution(); print(tf.reduce_sum(tf.random_normal([1000, 1000])))"


# Install Keras ----

# install HDF5. It will allow you to save your Keras models to disk quickly and efficiently [3]
apt install -y libhdf5-serial-dev python-h5py

# install Keras
pip3 install keras

# install for R
Rscript -e "install.packages('keras');library(keras);install_keras()" #! print install_keras(tensorflow='gpu') for using GPU 



# References ----
# 1. https://www.tensorflow.org/install/install_linux#NVIDIARequirements
# 2. https://www.tensorflow.org/install/pip?lang=python3
# 3. https://keras.io/#installation
# 4. https://livebook.manning.com/#!/book/deep-learning-with-r/appendix-a/1
