
# Cloud Deep Learning Server

___Deep Learning Server on Ubuntu Server 20.04 (Azure VM, GPU Instance)___

## Software / Frameworks

Installing software/frameworks:

- [x] CUDA drivers
- [x] ML/DL frameworks:
  - [x] Tensorflow (with GPU support)
  - [x] Keras (with GPU support)
  - [x] LightGBM (with GPU support)
  - [x] H2O Open
- [x] R CRAN 
  - [x] with pre-installed basic R-packages
- [x] RStudio Server
  - [x] with Azure Database Service connector
- [x] JupyterLab
- [ ] VS Code Server
- [x] .NET Core and Powershell Core
- [x] Docker
- [x] Git configure
- [x] Kaggle configure

## Instructions

### Preparation

`git clone https://github.com/codez0mb1e/cloud-rstudio-server.git`

`cd cloud-rstudio-server/scripts`

`mkdir logs`

### Installation scripts

1. sudo sh [install_core.sh](/scripts/install_core.sh) &>logs/install_core.log
1. sudo sh [install_cuda_drivers.sh](/scripts/install_cuda_drivers.sh) &>logs/install_cuda_drivers.log
1. sudo sh [install_deep_learning.sh](/scripts/install_deep_learning.sh) &>logs/install_deep_learning.log
1. sudo sh [install_ml_python.sh](/scripts/install_ml_python.sh) > log/install_ml_python.log
1. sudo sh [install_r_env.sh](/scripts/install_r_env.sh) &>logs/install_r.log
1. Rscript [install_r_packages.R](/scripts/install_r_packages.R) &>logs/install_r_packages.log <sup>1</sup>
1. sudo sh [install_lightgbm.sh](/scripts/install_lightgbm.sh) &>logs/install_lightgbm.log <sup>1</sup>
1. sudo sh [git_configure.sh](/scripts/git_configure.sh) &>logs/git_configure.log <sup>1</sup>
1. sudo sh [kaggle_configure.sh](/scripts/kaggle_configure.sh) &>logs/kaggle_configure.log <sup>1</sup>
1. sudo sh [install_dotnet_tools.sh](/scripts/install_dotnet_tools.sh) &>logs/install_dotnet_core.log
1. sudo sh [install_docker.sh](/scripts/install_docker.sh) &>logs/install_docker.log

<sup>1</sup> Install under RStudio user

### Tests

1. [keras_install_tests.R](/tests/keras_install_tests.R)
1. [lightgbm_install_tests.R](/tests/lightgbm_install_tests.R)
