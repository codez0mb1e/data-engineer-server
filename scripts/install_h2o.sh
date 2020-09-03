#!/bin/bash

#
# Install H2O framework
#


# 1. Download and unpack
H2O_VERSION="3.30.1.1"; readonly H2O_VERSION  # note: check number of latest version [1]


wget http://h2o-release.s3.amazonaws.com/h2o/rel-zahradnik/1/h2o-${H2O_VERSION}.zip
unzip h2o-${H2O_VERSION}.zip

cd h2o-${H2O_VERSION}


# 2. Install
java -jar h2o.jar


# 3. Create SSH tunnel and point your browser to http://localhost:54321


# 4. Install H2O R-package
cd R

Rscript -e "install.packages(c('RCurl', 'jsonlite'))"
R CMD INSTALL h2o_${H2O_VERSION}.tar.gz


# 5. Test installation
Rscript -e "library(h2o); h2o.init()"


# References ----
# 1. http://h2o-release.s3.amazonaws.com/h2o/latest_stable.html
