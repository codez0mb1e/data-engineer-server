
# Cloud RStudio Server

___RStudio Server with Deep Learning on Azure GPU VM___


## Installation Scripts

Script:

- [x] CUDA drivers
- [x] ML/DL frameworks:
  - [x] Tensorflow (with GPU support)
  - [x] Keras (with GPU support)
  - [x] LightGBM (with GPU support)
  - [x] .NET Core (latest)
- [x] Microsoft R Open 
  - [x] with pre-installed basic R-packages
- [x] RStudio Server
  - [x] with Azure Database connector
- [x] Docker
- [x] Git configure


## Instructions

#### Prepare

`mkdir repos; cd repos`

`git clone https://github.com/codez0mb1e/cloud-rstudio-server.git`

`cd cloud-rstudio-server/scripts`

`mkdir logs`


#### Installation scripts

1. sudo [init.sh](/scripts/init.sh) > logs/init.log

1. sudo [install_cuda_drivers.v10.0.sh](/scripts/install_cuda_drivers.v10.0.sh) > logs/install_cuda_drivers.log

1. sudo [install_tensorflow.sh](/scripts/install_tensorflow.sh) > logs/install_tensorflow.log

1. sudo [install_r.sh](/scripts/install_r.sh) > logs/install_r.log

1. Rscript [install_r_packages.R](/scripts/install_r_packages.R) > logs/install_r_packages.log (install under rstudio user)

1. sudo [install_lightgbm.sh](/scripts/install_lightgbm.sh) > logs/install_lightgbm.log (install under rstudio user)

1. sudo [git_configure.sh](/scripts/git_configure.sh) > logs/git_configure.log (install under rstudio user)

1. sudo [kaggle_configure.sh](/scripts/kaggle_configure.sh) > logs/kaggle_configure.log (install under rstudio user)

1. sudo [install_dotnet_core.sh](/scripts/install_dotnet_core.sh) > logs/install_dotnet_core.log

1. sudo [install_docker.sh](/scripts/install_docker.sh) > logs/install_docker.log


#### Test installation

1. [keras_install_tests.R](/tests/keras_install_tests.R)

1. [lightgbm_install_tests.R](/tests/lightgbm_install_tests.R)



## ARM Templates (beta)
Azure Resource Manager (ARM) templates allow automatic deployment Azure VM with:
- [x] GPU instance VM
- [ ] OS Ubuntu Server 18.04
- [x] Login only via SSH public key
- [x] Network security settings for specified subset
- [x] DNS name

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fcodez0mb1e%2FMinotaur%2Fmaster%2Fsource%2FARMs%2Frstudio-server--ubuntu%2Fazuredeploy.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png" />
</a>
<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2Fcodez0mb1e%2FMinotaur%2Fmaster%2Fsource%2FARMs%2Frstudio-server--ubuntu%2Fazuredeploy.json" target="_blank">
    <img src="http://armviz.io/visualizebutton.png"/>
</a>
