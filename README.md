# stan-cmdstanr-gpu-docker

[![pages-build-deployment](https://github.com/JBris/stan-cmdstanr-gpu-docker/actions/workflows/pages/pages-build-deployment/badge.svg?branch=main)](https://github.com/JBris/stan-cmdstanr-gpu-docker/actions/workflows/pages/pages-build-deployment)

## Table of Contents  

- [stan-cmdstanr-gpu-docker](#stan-cmdstanr-gpu-docker)
  - [Table of Contents](#table-of-contents)
    - [Introduction](#introduction)
    - [Stan](#stan)
    - [Docker](#docker)

### Introduction

A Docker image to run Stan, cmdstanr, and brms for Bayesian statistical modelling - with GPU support.

Launch an RStudio webserver using `bash stan_up.sh`.

Execute `bash docker_pull.sh` to pull the image.

To convert the image into an Apptainer image, run `bash apptainer_pull.sh`.

### Stan

The following packages are installed during the image build process:

* [Stan](https://mc-stan.org/)
* [rstan](https://mc-stan.org/users/interfaces/rstan)
* [rstanarm](https://mc-stan.org/rstanarm/)
* [cmdstan](https://mc-stan.org/users/interfaces/cmdstan)
* [brms](https://paul-buerkner.github.io/brms/)
* [posterior](https://mc-stan.org/posterior/)
* [tidybayes](https://mjskay.github.io/tidybayes/)
* [bayesplot](https://mc-stan.org/bayesplot/)
* [posterior](https://mc-stan.org/posterior/)
* [rstantools](https://mc-stan.org/rstantools/)
* [projpred](https://mc-stan.org/projpred/)
* [shinystan](https://mc-stan.org/shinystan/)

The [brms_within_chain_parallelization.R](brms_within_chain_parallelization.R) script can be executed within the Docker container to evaluate whether within-chain parallelization, CmdStan, brms, and OpenCL are working properly.

### Docker

This Docker image extends from `rocker/tidyverse`. [Click this link for more information about the Rocker project.](https://rocker-project.org/images/)

Running the Docker container will launch an RStudio web server. You can access RStudio by visiting localhost:$R_STUDIO_PORT on your web browser. See [.env](.env) for the defined environment variables.

Running docker-compose will bind a volume, mapping the container's `home` directory to a local `r_home` directory.

See the [Dockerfile](Dockerfile) for the instructions executed during the build of the Docker image. 

View [docker-compose.yaml](docker-compose.yaml) to see the definition for the Stan service.

