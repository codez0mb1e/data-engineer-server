#!/bin/bash

#
# Data Platform
#


# 1. Install ArangoDB [1, 2] ----
## Set params
ARANGODB_INSTANCE="ariadne"; readonly ARANGODB_INSTANCE
ARANGODB_VERSION="3.11.6"; readonly ARANGODB_VERSION
ARANGODB_PWD="***"; readonly ARANGODB_PWD
DATA_DIR="/data/arangodb"; readonly DATA_DIR
LOG_DIR="/loga/arangodb"; readonly LOG_DIR

## Prepare
docker pull arangodb/arangodb:${ARANGODB_VERSION}
mkdir -p ${DATA_DIR}; mkdir -p ${LOG_DIR}

## Run
docker run -e ARANGO_ROOT_PASSWORD=${ARANGODB_PWD} -d \
    -p 8529:8529 \
    -v ${DATA_DIR}:/var/lib/arangodb3 \
    -v ${LOG_DIR}:/var/log/arangodb3 \
    --restart unless-stopped
    --name ${ARANGODB_INSTANCE} \
    arangodb/arangodb:${ARANGODB_VERSION}
    --log.output file:///var/log/arangodb3/dbserver.log

## Validate
docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${ARANGODB_INSTANCE}
# Open http://localhost:8529


# References ----
# 1. https://hub.docker.com/_/arangodb
# 2. https://www.arangodb.com/docs/stable/install-with-docker.html
