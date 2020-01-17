#!/bin/bash

#
# Install H2O
#


# 1. Download and unpack
H2O_VERSION="3.28.0.1"; readonly H2O_VERSION

wget http://h2o-release.s3.amazonaws.com/h2o/rel-yu/1/h2o-${H2O_VERSION}.zip
unzip h2o-${H2O_VERSION}.zip

cd h2o-${H2O_VERSION}

# 2. Install
java -jar h2o.jar

# 3. Point your browser to http://localhost:54321


# References ----
# 1. http://h2o-release.s3.amazonaws.com/h2o/latest_stable.html
