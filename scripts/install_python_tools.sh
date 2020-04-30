#!/bin/bash

#
# Install python development tools
#


# Core libs ----
apt install python3-tk 


# Jupyter lab ----
pip install jupyterlab


#! warn: set correct reticulate version in RStudio
#> library(reticulate)
#> use_python(python = Sys.which("python3"), required = TRUE)
#> py_config()
