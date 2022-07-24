#!/usr/bin/python3

""" Hello Python
"""

# %% Import dependencies ----
# core
import os
import gc

# data science
import pandas as pd
import numpy as np

# tools
from logging import Logger

# show info about python env
from IPython import sys_info

# %%
print(os.getcwd())

print(sys_info())

gc.collect()
