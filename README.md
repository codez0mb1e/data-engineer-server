
# Cloud Deep Learning Server

___Deep Learning Server on Ubuntu Server 20.04 (Azure VM, GPU Instance)___

## Software / Frameworks

Installing software/frameworks:

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
- [x] VS Code Server
- [x] .NET Core and Powershell Core
- [x] Docker
- [x] Git configure

## Instructions

### Preparation

```sh
git clone https://github.com/codez0mb1e/cloud-deep-learning-server.git

cd cloud-deep-learning-server/src
mkdir logs
```

### Installation scripts

1. sudo sh [install_core.sh](/src/install_core.sh) &>logs/install_core.log
2. sudo sh [install_docker.sh](/src/install_docker.sh) &>logs/install_docker.log
3. sudo sh [git_configure.sh](/src/git_configure.sh) &>logs/git_configure.log <sup>1</sup>
4. sudo sh [install_dotnet_tools.sh](/src/install_dotnet_tools.sh) &>logs/install_dotnet_core.log
5. sudo sh [install_ds_python.sh](/src/install_ds_python.sh) > log/install_ds_python.log
6. sudo sh [install_deep_learning.sh](/src/install_deep_learning.sh) &>logs/install_deep_learning.log
7. sudo sh [install_r_env.sh](/src/install_r_env.sh) &>logs/install_r.log
8. Rscript [install_r_packages.R](/src/install_r_packages.R) &>logs/install_r_packages.log <sup>1</sup>
9. sudo sh [install_lightgbm.sh](/src/install_lightgbm.sh) &>logs/install_lightgbm.log <sup>1</sup>

<sup>1</sup> Install under RStudio user

### Tests

1. [Keras installation tests](/tests/keras_install_tests.R)
1. [LightGBM installation test](/tests/lightgbm_install_tests.R)
1. [Jupiter Notebook installation tests](/tests/hello_jupyter.ipynb)
