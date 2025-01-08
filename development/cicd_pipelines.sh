#!/bin/bash

#
# Configure CI/CD pipelines
#


# 1. GitHub Actions (self-hosted agent) ----
# Set up
# Go to the repository settings -> Actions -> Add runner
# https://github.com/<your_account>/<your_repo>/settings/actions/runners/new?arch=x64&os=linux
# and follow the instructions

# Run as a service [1]
sudo ./svc.sh install
sudo ./svc.sh start

# References
# 1. https://docs.github.com/en/actions/hosting-your-own-runners/managing-self-hosted-runners/configuring-the-self-hosted-runner-application-as-a-service
