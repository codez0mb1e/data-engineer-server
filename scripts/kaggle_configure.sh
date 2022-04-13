#!/bin/bash

#
# Kaggle API tools
#


USR="dp"; readonly USR


# install
pip install --user $USR kaggle

# now upload kaggle.json from https://www.kaggle.com/<username>/account to ~/.kaggle/kaggle.json
chmod 600 ~/.kaggle/kaggle.json


# References ----
# 1. https://github.com/Kaggle/kaggle-api
# 2. https://stackoverflow.com/questions/48370064/pip-install-kaggle-works-fine-but-kg-command-not-found
