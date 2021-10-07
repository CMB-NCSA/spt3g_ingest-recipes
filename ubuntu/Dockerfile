# To build:
# export SPTUSER=$USER
# docker build -t spt3g_ubuntu --build-arg SPTUSER --rm=true .

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
RUN apt-get install -y python3-fitsio python3-yaml
RUN apt install -y python3-pandas
RUN apt-get install -y python-is-python3

# cfitsio/fpack
RUN apt-get install -y libcfitsio-bin

RUN mkdir -p /opt/spt \
    && cd /opt/spt

COPY spt3g_software /opt/spt/spt3g_software
WORKDIR /opt/spt

# Build the spt3g software
RUN cd spt3g_software \
    && mkdir build \
    && cd build \
    && cmake ..\
    && make \
    && ./env-shell.sh make docs


# Add $SPTUSER as user and create groups wheel and spt
ARG SPTUSER
RUN useradd -ms /bin/bash -u 1001 $SPTUSER && \
    addgroup wheel && \
    addgroup -gid 1003 spt

# Add $SPTUSER to wheel and spt
RUN usermod -aG wheel $SPTUSER && \
    usermod -aG spt $SPTUSER

# Make mount directory to mirror /data/spt3g
RUN mkdir -p /data/spt3g && \
    chgrp spt /data/spt3g && \
    chmod g+wrx /data/spt3g

ENV USER $SPTUSER
ENV HOME /home/$SPTUSER
ENV SHELL /bin/bash

USER $SPTUSER
WORKDIR /home/$SPTUSER
