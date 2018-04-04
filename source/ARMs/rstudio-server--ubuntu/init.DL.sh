
## install updates ----
apt-get -y update
apt-get -y dist-upgrade

## core libs ----
apt-get -y install build-essential libssl-dev cmake



## install Tensorflow ----
# install, create, and activate Virtualenv [3]
apt-get -y install python3-pip python3-dev python-virtualenv
virtualenv --system-site-packages -p python3 ~/tensorflow
source ~/tensorflow/bin/activate

# ensure pip ≥8.1 is installed [3]
easy_install -U pip

# install TensorFlow in the active Virtualenv environment [3]
pip3 install --upgrade tensorflow-gpu



## install Keras ----
# install a BLAS library to ensure that you can run fast tensor operations on your CPU [1]
apt-get -y install unzip pkg-config libopenblas-dev liblapack-dev

# install the Python scientific suite [1]
apt-get -y install python-numpy python-scipy python-matplotlib python-yaml

# install HDF5. This library, originally developed by NASA, stores large files of numeric
# data in an efficient binary format. It will allow you to save your Keras models to disk
# quickly and efficiently [1]
apt-get -y install libhdf5-serial-dev python-h5py

# install Keras from PyPI [2]
pip install keras #? pip3 
# or for upgrade existing [2]
pip install keras --upgrade pip #? pip3 



## install R and R tools ----
wget https://mran.blob.core.windows.net/install/mro/3.4.3/microsoft-r-open-3.4.3.tar.gz
tar -xf microsoft-r-open-3.4.3.tar.gz
cd microsoft-r-open/
./install.sh -u

R --version


# RStudio Server
apt-get install gdebi-core
wget https://download2.rstudio.org/rstudio-server-1.1.423-amd64.deb
gdebi rstudio-server-1.1.423-amd64.deb

rstudio-server status


# R-packages dependencies
apt-get -y install gfortran libcurl4-openssl-dev 

# install SQL Server drivers
sudo su 
curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list > /etc/apt/sources.list.d/mssql-release.list
exit 

sudo apt-get update
sudo ACCEPT_EULA=Y apt-get install msodbcsql

sudo apt-get -y install unixodbc unixodbc-dev #? tdsodbc



## install LightGBM ----
git clone --recursive https://github.com/Microsoft/LightGBM
cd LightGBM/R-package
R CMD INSTALL --build . --no-multiarch



## install CNTK (todo: section needs to be checked) ----
# core
apt-get -y install python3-pip python3-dev
apt-get -y install libopencv-dev python-opencv

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



## install tools ----
apt-get -y install htop # and git, nvidia-smi if not already installed

git --version
git config --global user.name "Dmitry Petukhov"
git config --global user.email "dpetukhov@openwaygroup.com"
git config --list



## References: ----
# [1] Deep_Learning_with_R_v1_MEAP
# [2] https://keras.io/#installation
# [3] https://www.tensorflow.org/install/install_linux

