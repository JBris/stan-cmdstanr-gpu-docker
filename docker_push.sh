#!/usr/bin/env bash

. .env

###################################################################
# Main
###################################################################

docker compose push ghcr.io/jbris/stan-cmdstanr-gpu-docker:${CMDSTAN_VERSION}
