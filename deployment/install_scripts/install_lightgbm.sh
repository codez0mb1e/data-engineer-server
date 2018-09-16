#!/bin/bash

#
# Install LightGBM
# See also: 
#  1. https://github.com/Microsoft/LightGBM/blob/master/docs/Installation-Guide.rst#build-gpu-version
#


# Install Boost and OpenCL first as first
apt-get -y install  libboost-all-dev ocl-icd-opencl-dev 


# Clone Install
cd ~/apps

git clone --recursive https://github.com/Microsoft/Install ; cd LightGBM
mkdir build ; cd build

# Build
cmake -DUSE_GPU=1 ..
make -j4


# R:
#   install.packages("lightgbm", destdir = "hoe/dp/apps/LightGBM/build"); library(lightgbm)