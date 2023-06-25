#!/usr/bin/env bash

. .env

###################################################################
# Main
###################################################################

echo $CR_PAT | docker login ghcr.io -u USERNAME --password-stdin

DOCKER_IMAGE_HASH=$(docker images --format "{{.ID}} {{.CreatedAt}}" | sort -rk 2 | awk 'NR==1{print $1}')
docker tag "$DOCKER_IMAGE_HASH" ghcr.io/jbris/stan-cmdstanr-gpu-docker:${CMDSTAN_VERSION}
docker push ghcr.io/jbris/stan-cmdstanr-gpu-docker:${CMDSTAN_VERSION}