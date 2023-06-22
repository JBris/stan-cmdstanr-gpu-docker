#!/usr/bin/env bash

. .env

###################################################################
# Main
###################################################################

docker pull ghcr.io/jbris/stan-cmdstanr-gpu-docker:${CMDSTAN_VERSION}