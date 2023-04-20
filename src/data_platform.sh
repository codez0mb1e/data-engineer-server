#!/bin/bash

#
# Data Platform
#


# 1. Install ArangoDB [1, 2] ----
## Set params
ARANGODB_INSTANCE="ariadne"; readonly ARANGODB_INSTANCE
ARANGODB_VERSION="3.10.5.2"; readonly ARANGODB_VERSION
ARANGODB_PWD="***"; readonly ARANGODB_PWD
ARAGONDB_DATA_DIR="/data/arangodb"; readonly ARAGONDB_DATA_DIR

## Prepare
docker pull arangodb/arangodb:${ARANGODB_VERSION}
mkdir -p ${ARAGONDB_DATA_DIR}

## Run
docker run -e ARANGO_ROOT_PASSWORD=${ARANGODB_PWD} -d \
    -p 8529:8529 \
    -v ${ARAGONDB_DATA_DIR}:/var/lib/arangodb3 \
    --name ${ARANGODB_INSTANCE} \
    arangodb/arangodb:${ARANGODB_VERSION}

## Validate
docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${ARANGODB_INSTANCE}
# Open http://localhost:8529


# References ----
# 1. https://hub.docker.com/_/arangodb
# 2. https://www.arangodb.com/docs/stable/install-with-docker.html
