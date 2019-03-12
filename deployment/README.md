
- Automatic deployment template Azure VM:
    - GPU instance
    - Login SSH public key
    - Network security settings for specified subset
    - DNS name
- Script for installation:
    - CUDA drivers
    - ML/DL frameworks:
       - Tensorflow (with GPU support)
       - Keras (with GPU support)
       - LightGBM (with GPU support)
    - .NET Core 2.2
    - Microsoft R Open with pre-installed basic R-packages
    - RStudio Server with Azure SQL Database connector
    - Docker
    - Git configure
 

ARM templates for ububntu server 18.04:
1. [azuredeploy.json](/arm_templates/azuredeploy.json)
1. [azuredeploy.parameters.json](/arm_templates/azuredeploy.parameters.json)


Prepare:
`git clone https://github.com/codez0mb1e/Minotaur.git`

`mkdir logs`

Install scripts:

`sudo [init.sh](/install_scripts/init.sh) > logs/init.log`

`sudo [install_cuda_drivers.v9.0.sh](/install_scripts/install_cuda_drivers.v9.0.sh) > logs/install_cuda_drivers.log`

`sudo [install_tensorflow.sh](/install_scripts/install_tensorflow.sh) > logs/install_tensorflow.log`

`sudo [install_docker.sh](/install_scripts/install_docker.sh) > logs/install_docker.log`

`sudo [install_r.sh](/install_scripts/install_r.sh) > logs/install_r.log`

`# (install under rstudio user)`

`sudo [install_lightgbm.sh](/install_scripts/install_lightgbm.sh) > logs/install_lightgbm.log`

`# (install under rstudio user)`

`sudo [git_configure.sh](/install_scripts/git_configure.sh) > logs/git_configure.log`

`# (install under rstudio user)`

`sudo [kaggle_configure.sh](/install_scripts/kaggle_configure.sh) > logs/kaggle_configure.log`

`# (install under rstudio user)`
`Rscript [install_r_packages.R](/install_scripts/install_r_packages.R) > logs/install_r_packages.log`

`sudo [install_dotnet_core.sh](/install_scripts/install_dotnet_core.sh) > logs/install_dotnet_core.log`

`sudo [install_docker.sh](/install_scripts/install_docker.sh) > logs/install_docker.log`

Test installation:
1. [keras_install_tests.R](/tests/keras_install_tests.R)
1. [lightgbm_install_tests.R](/tests/lightgbm_install_tests.R)



<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fcodez0mb1e%2FMinotaur%2Fmaster%2Fsource%2FARMs%2Frstudio-server--ubuntu%2Fazuredeploy.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png" />
</a>
<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2Fcodez0mb1e%2FMinotaur%2Fmaster%2Fsource%2FARMs%2Frstudio-server--ubuntu%2Fazuredeploy.json" target="_blank">
    <img src="http://armviz.io/visualizebutton.png"/>
</a>
