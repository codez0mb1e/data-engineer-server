#!/bin/bash

#
# Install Computer Vision frameworks and tools
#

cat /usr/local/cuda/version.txt

pip3 install torch torchvision
python3 -c 'import torch; assert(torch.cuda.is_available()); print(torch.__version__)'

apt install python3-opencv
python3 -c 'import cv2; print(cv2.__version__)'

pip3 install captcha
python3 -c 'import captcha; print(captcha.__version__)'
