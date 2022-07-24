#!/bin/bash

#
# Install Tensorflow and PyTorch
#


# Install Tensorflow ---- 
pip install tensorflow-gpu

# validate installation 
python3 -c "import tensorflow as tf; print(tf.math.reduce_sum(tf.random.normal([1000, 1000])))"
python3 -c "import tensorflow as tf; print(tf.config.list_physical_devices('GPU')); print(tf.__version__)" 


# Install PyTorch ----
pip install -y torch==1.9.0+cu111 torchvision==0.10.0+cu111 torchaudio==0.9.0 -f https://download.pytorch.org/whl/torch_stable.html
python3 -c "import torch; print(torch.cuda.is_available()); x = torch.rand(5, 3); print(x)"



# References ----
# 1. https://www.tensorflow.org/install/gpu
# 2. https://pytorch.org/get-started/locally/#start-locally
# 3. https://pytorch-forecasting.readthedocs.io/en/latest/getting-started.html#installation
