# 

- Automatic deployment template Azure VM:
    - GPU instance
    - Login SSH public key
    - Network security settings for specified subset
    - DNS name
- Script for installation:
    - CUDA drivers
    - Microsoft R Open with preinstalled basic R-packages
    - RStudio Server with Azure SQL Database connector
    - ML/DL frameworks: Tensorflow, Keras, LightGBM (all with GPU support)
    - Keras (with GPU support)
    - LightGBM (with GPU support)
    - Git configure
 

ARM templates:
1. [azuredeploy.json](/arm_templates/azuredeploy.json)
1. [azuredeploy.parameters.json](/arm_templates/azuredeploy.parameters.json)


Prepare:
`git clone https://github.com/codez0mb1e/Minotaur.git`

`mkdir logs`

Install scripts
1. sudo [init.sh](/install_scripts/init.sh) > logs/init.log
2. sudo [install_cuda_drivers.v9.0.sh](/install_scripts/install_cuda_drivers.v9.0.sh) > logs/install_cuda_drivers.log
1. sudo [install_tensorflow.sh](/install_scripts/install_tensorflow.sh) > logs/install_tensorflow.log
1. sudo [install_r.sh](/install_scripts/install_r.sh) > logs/install_r.log
1. (install under rstudio user) sudo [install_lightgbm.sh](/install_scripts/install_lightgbm.sh) > logs/install_lightgbm.log
1. (install under rstudio user) sudo [git_configure.sh](/install_scripts/git_configure.sh) > logs/git_configure.log
6. (install under rstudio user) sudo [kaggle_configure.sh](/install_scripts/kaggle_configure.sh) > logs/kaggle_configure.log
8. Rscript [install_r_packages.R](/install_scripts/install_r_packages.R) > logs/install_r_packages.log

Test installation:
1. [keras_install_tests.R](/tests/keras_install_tests.R)
2. [lightgbm_install_tests.R](/tests/lightgbm_install_tests.R)