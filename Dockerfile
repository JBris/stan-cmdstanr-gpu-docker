ARG TIDYVERSE_TAG

FROM rocker/tidyverse:${TIDYVERSE_TAG}

RUN apt-get update -y \
  && apt-get install -y --no-install-recommends libglpk-dev clang-3.6 clinfo pocl-opencl-icd nvidia-settings nvidia-cuda-toolkit \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /tmp/downloaded_packages

RUN mkdir -p $HOME/.R/ \ 
  && echo "CXX=clang++ -stdlib=libc++ -fsanitize=address,undefined -fno-sanitize=float-divide-by-zero -fno-omit-frame-pointer -fsanitize-address-use-after-scope -fno-sanitize=alignment -frtti" >> $HOME/.R/Makevars \
  && echo "CC=clang -fsanitize=address,undefined -fno-sanitize=float-divide-by-zero -fno-omit-frame-pointer -fsanitize-address-use-after-scope -fno-sanitize=alignment" >> $HOME/.R/Makevars \
  && echo "CFLAGS=-O3 -Wall -pedantic -mtune=native" >> $HOME/.R/Makevars \
  && echo "FFLAGS=-O2 -mtune=native" >> $HOME/.R/Makevars \
  && echo "FCFLAGS=-O2 -mtune=native" >> $HOME/.R/Makevars \
  && echo "CXXFLAGS=-O3 -march=native -mtune=native -fPIC" >> $HOME/.R/Makevars \
  && echo "MAIN_LD=clang++ -stdlib=libc++ -fsanitize=undefined,address" >> $HOME/.R/Makevars \
  && echo "rstan::rstan_options(auto_write = TRUE)" >> $HOME/.Rprofile \
  && echo "options(mc.cores = parallel::detectCores())" >> $HOME/.Rprofile

ENV CMDSTAN /usr/share/.cmdstan

ARG CMDSTAN_VERSION

RUN cd /usr/share/ \
  && wget --progress=dot:mega https://github.com/stan-dev/cmdstan/releases/download/v${CMDSTAN_VERSION}/cmdstan-${CMDSTAN_VERSION}.tar.gz \
  && tar -zxpf cmdstan-${CMDSTAN_VERSION}.tar.gz \
  && rm cmdstan-${CMDSTAN_VERSION}.tar.gz \
  && mv cmdstan-${CMDSTAN_VERSION} .cmdstan \
  && ln -s .cmdstan cmdstan && cd .cmdstan && echo "CXX = clang++" >> make/local \
  && make build

ENV DOWNLOAD_STATIC_LIBV8 1

RUN install2.r --error --skipmissing --skipinstalled -n -1 rstan

RUN Rscript -e 'install.packages("cmdstanr", repos = c("https://mc-stan.org/r-packages/", getOption("repos")))' 

RUN install2.r --error --skipmissing --skipinstalled -n -1 \
  renv \
  here \ 
  rstanarm \
  brms \
  loo \
  tidybayes \
  bayesplot \
  posterior \ 
  rstantools \
  projpred \
  shinystan \
  future \
  yaml \
  reshape2 \
  testthat \ 
  targets

RUN strip /usr/local/lib/R/site-library/*/libs/*.so
