#!/bin/bash

#
# Install Tensorflow and Keras
#


# Check Python, pip, and virtualenv versions ----
python3 --version
pip --version

apt install -y python3-dev python3-pip python3-virtualenv
virtualenv --version



# Install Tensorflow ---- 
pip install tensorflow-gpu

# validate installation 
python3 -c "import tensorflow as tf; print(tf.math.reduce_sum(tf.random.normal([1000, 1000])))"
python3 -c "import tensorflow as tf; print(tf.config.list_physical_devices('GPU')); print(tf.__version__)" 



# Install PyTorch  ----
conda install pytorch torchvision torchaudio cpuonly -c pytorch
python3 -c "import torch;x = torch.rand(5, 3);print(x)"

conda install pytorch-forecasting pytorch>=1.7 -c pytorch -c conda-forge



# References ----
# 1. https://www.tensorflow.org/install/gpu
# 2. https://pytorch.org/get-started/locally/#start-locally
# 3. https://pytorch-forecasting.readthedocs.io/en/latest/getting-started.html#installation
