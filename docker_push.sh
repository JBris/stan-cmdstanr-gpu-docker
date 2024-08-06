#!/usr/bin/env bash

. .env

###################################################################
# Main
###################################################################

docker push ghcr.io/jbris/stan-cmdstanr-gpu-docker:${CMDSTAN_VERSION}
