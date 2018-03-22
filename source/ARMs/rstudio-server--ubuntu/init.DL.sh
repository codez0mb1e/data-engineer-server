
## install updates and core ----
sudo apt-get -y update
sudo apt-get -y dist-upgrade

# core
apt-get -y install build-essential libssl-dev



## install Python ----
sudo apt install checkinstall
sudo apt install libreadline-gplv2-dev libncursesw5-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev zlib1g-dev
sudo wget https://www.python.org/ftp/python/3.6.3/Python-3.6.3.tgz
sudo tar xvf Python-3.6.3.tgz

cd Python-3.6.3/
sudo ./configure
sudo make install #? altinstall

python3.6 -V



## install R ----
sudo wget https://mran.blob.core.windows.net/install/mro/3.4.3/microsoft-r-open-3.4.3.tar.gz
tar -xf microsoft-r-open-3.4.3.tar.gz
cd microsoft-r-open/
sudo ./install.sh -u

R -v


# RStudio Server
sudo apt-get install gdebi-core
wget https://download2.rstudio.org/rstudio-server-1.1.423-amd64.deb
sudo gdebi rstudio-server-1.1.423-amd64.deb

rstudio-server status


# R-packages dependencies
sudo apt-get -y install gfortran libcurl4-openssl-dev 

# install SQL Server drivers
sudo su 
curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list > /etc/apt/sources.list.d/mssql-release.list
exit 

sudo apt-get update
sudo ACCEPT_EULA=Y apt-get install msodbcsql

sudo apt-get -y install unixodbc unixodbc-dev #? tdsodbc



## LightGBM
sudo apt-get -y install cmake
git clone --recursive https://github.com/Microsoft/LightGBM
cd LightGBM/R-package
R CMD INSTALL --build . --no-multiarch



## tools ----
apt-get -y install htop

git --version
git config --global user.name "Dmitry Petukhov"
git config --global user.email "dpetukhov@openwaygroup.com"
git config --list



## install DL frameworks ----
# core
sudo apt-get -y install python3-pip python3-dev
sudo apt-get -y install libopencv-dev python-opencv


# CNTK
wget https://repo.continuum.io/archive/Anaconda3-5.1.0-Linux-x86_64.sh
sh Anaconda3-5.1.0-Linux-x86_64.sh

# source: https://microsoft.github.io/CNTK-R//articles/installation.html
conda create -n cntk-py36 python=3.6 anaconda
source activate cntk-py36

# full list of wheels https://github.com/Microsoft/CNTK/blob/master/README.md
pip install https://cntk.ai/PythonWheel/CPU-Only/cntk-2.3.1-cp36-cp36m-linux_x86_64.whl # https://cntk.ai/PythonWheel/GPU/cntk-2.3.1-cp36-cp36m-linux_x86_64.whl


R
> Sys.setenv(RETICULATE_PYTHON="/home/dp/anaconda3/envs/cntk-py36/bin/python")
> reticulate::py_module_available("cntk")










