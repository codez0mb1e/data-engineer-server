#!/bin/bash

#
# Data Platform
#


# 1. Install ArangoDB [1, 3] ----
## Set params
ARANGODB_INSTANCE="ariadne"; readonly ARANGODB_INSTANCE
ARANGODB_VERSION="3.11"; readonly ARANGODB_VERSION
ARANGODB_PWD="***"; readonly ARANGODB_PWD
DATA_DIR="/data/arangodb"; readonly DATA_DIR
LOG_DIR="/logs/arangodb"; readonly LOG_DIR

## Prepare
docker pull arangodb:${ARANGODB_VERSION}
mkdir -p ${DATA_DIR}; mkdir -p ${LOG_DIR}

## Run
docker run -d \
    -p 8529:8529 \
    -v ${DATA_DIR}:/var/lib/arangodb3 \
    -v ${LOG_DIR}:/var/log/arangodb3 \
    -e ARANGO_ROOT_PASSWORD=${ARANGODB_PWD} \
    --restart unless-stopped \
    --name ${ARANGODB_INSTANCE} \
    arangodb:${ARANGODB_VERSION}
    --log.output file:///var/log/arangodb3/dbserver.log

## Validate
docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${ARANGODB_INSTANCE}
# Open http://localhost:8529


# 2. Install InfluxDB [2] ----
## Set params
INFLUXDB_INSTANCE="influxdb2"; readonly INFLUXDB_INSTANCE
INFLUXDB_VERSION="2.7"; readonly INFLUXDB_VERSION
INFLUXDB_USER="root"; readonly INFLUXDB_USER
INFLUXDB_PWD="***"; readonly INFLUXDB_PWD
DATA_DIR="/data/influxdb"; readonly DATA_DIR
CONFIG_DIR="/services/influxdb2/config"; readonly CONFIG_DIR

## Prepare
docker pull influxdb:${INFLUXDB_VERSION}
mkdir -p ${DATA_DIR}; mkdir -p ${CONFIG_DIR}

## Run
docker run -d \
    -p 8086:8086 \
    -v ${DATA_DIR}:/var/lib/influxdb2 \
    -v ${CONFIG_DIR}:/etc/influxdb2 \
    -e DOCKER_INFLUXDB_INIT_MODE=setup \
    -e DOCKER_INFLUXDB_INIT_USERNAME=${INFLUXDB_USER}  \
    -e DOCKER_INFLUXDB_INIT_PASSWORD=${INFLUXDB_PWD}  \
    -e DOCKER_INFLUXDB_INIT_ORG=normalnoio \
    -e DOCKER_INFLUXDB_INIT_BUCKET=market-data \
    --restart unless-stopped \
    --name ${INFLUXDB_INSTANCE} \
    influxdb:${INFLUXDB_VERSION}

## Validate
docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${INFLUXDB_VERSION}
# Open http://localhost:8086


# References ----
# 1. https://hub.docker.com/_/arangodb
# 2. https://hub.docker.com/_/influxdb
# 3. https://www.arangodb.com/docs/stable/install-with-docker.html
