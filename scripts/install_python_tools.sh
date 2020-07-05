#!/bin/bash

#
# Install python development tools
#


# Core libs ----

# apt install python3-tk


# Jupyter lab ----

apt install -y nodejs
nodejs -v

pip install --upgrade pip --user <user>
pip install jupyterlab --user <user>

jupyter lab --version


#! warn: set correct reticulate version in RStudio
#> library(reticulate)
#> use_python(python = Sys.which("python3"), required = TRUE)
#> py_config()
