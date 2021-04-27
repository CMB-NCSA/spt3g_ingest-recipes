# To build:
# export GITUSER=menanteau
# export SPTUSER=$USER
# docker build -t spt3g_ubuntu --build-arg SPTUSER --build-arg GITUSER --build-arg GITPASS --rm=true .

# To start:
# hostname="`hostname -s`-docker"
# DOCKER_IMA=spt3g_ubuntu:latest
# docker run -ti -h $hostname -v $HOME/SPT-3G/home-spt3g:/home/$SPTUSER $DOCKER_IMA bash

# Clean up:
# docker rm $(docker ps -a -q)

FROM ubuntu:20.04

RUN apt-get update

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata
RUN apt-get install -y wget emacs git
# Pre-reqs from:
# https://southpoletelescope.github.io/spt3g_software/quickstart.html
RUN apt-get install -y cmake libboost-all-dev libflac-dev libnetcdf-dev libfftw3-dev libgsl0-dev

# Astropy/numpy/scipy
RUN apt-get install -y python3-numpy python3-scipy python3-astropy python3-sphinx
RUN apt-get install -y python3-numexpr python3-healpy ipython3
RUN apt-get install -y python-numpy
RUN apt-get install -y hdf5-tools hdf5-helpers
RUN apt-get install -y python-is-python3

# Github user and passwd
ARG GITUSER
ARG GITPASS

RUN mkdir -p /opt/spt \
    && cd /opt/spt

WORKDIR /opt/spt
RUN git clone https://$GITUSER:$GITPASS@github.com/SouthPoleTelescope/spt3g_software.git

# Build the spt3g software
RUN cd spt3g_software \
    && mkdir build \
    && cd build \
    && cmake ..\
    && make \
    && ./env-shell.sh make docs

# Add $SPTUSER as user
ARG SPTUSER
RUN useradd -ms /bin/bash $SPTUSER
RUN addgroup wheel
RUN usermod -aG wheel $SPTUSER

ENV USER $SPTUSER/
ENV HOME /home/$SPTUSER
ENV SHELL /bin/bash

USER $SPTUSER
WORKDIR /home/$SPTUSER

