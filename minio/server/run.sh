#!/bin/bash

# read env vars
source .env

# create a network and volume
docker network create backend
docker volume create minio_data

# run minio server
docker compose up -d
