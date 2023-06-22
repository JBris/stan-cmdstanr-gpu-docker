#!/usr/bin/env bash

. .env

###################################################################
# Main
###################################################################

apptainer pull docker://ghcr.io/jbris/stan-cmdstanr-gpu-docker:${CMDSTAN_VERSION}