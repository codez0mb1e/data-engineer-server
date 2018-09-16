#!/bin/bash

#
# Install LightGBM script
# 


# install Boost and OpenCL
apt-get -y install libboost-all-dev ocl-icd-opencl-dev 

# clone LightGBM
git clone --recursive https://github.com/Microsoft/LightGBM
cd LightGBM

# build LightGBM
mkdir build ; cd build
cmake -DUSE_GPU=1 ..
make -j4

# test
# Rscript "install.packages('lightgbm', destdir = 'home/<user>/LightGBM/build'); library(lightgbm)"


# References ----
# 1. https://github.com/Microsoft/LightGBM/blob/master/docs/Installation-Guide.rst#build-gpu-version
