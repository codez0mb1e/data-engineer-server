#!/bin/bash

#
# Install H2O
#


H2O_VERSION="3.26.0.5"; readonly H2O_VERSION

wget http://h2o-release.s3.amazonaws.com/h2o/rel-yau/5/h2o-${H2O_VERSION}.zip
unzip h2o-${H2O_VERSION}.zip

cd h2o-${H2O_VERSION}

java -jar h2o.jar


# References ----
# 1. http://h2o-release.s3.amazonaws.com/h2o/rel-yau/5/index.html
