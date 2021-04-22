# To build:
# export GITUSER=menanteau
# docker build -t spt3g_ubuntu --build-arg GITUSER --build-arg GITPASS --rm=true .

# Clean up:
# docker rm $(docker ps -a -q)

FROM ubuntu:18.04

RUN apt-get update
RUN apt-get install -y wget emacs git
# Pre-reqs from:
# https://southpoletelescope.github.io/spt3g_software/quickstart.html
RUN apt-get install -y cmake libboost-all-dev libflac-dev libnetcdf-dev libfftw3-dev libgsl0-dev

# Astropy/numpy/scipy
RUN apt-get install -y python3-numpy python3-scipy python3-astropy
RUN apt-get install -y python-numpy python-scipy python-astropy
RUN apt-get install -y hdf5-tools hdf5-helpers


# Add $SPTUSER as user
ARG SPTUSER
RUN useradd -ms /bin/bash $SPTUSER
RUN addgroup wheel
RUN usermod -aG wheel $SPTUSER

ENV USER $SPTUSER
ENV HOME /home/$SPTUSER
ENV SHELL /bin/bash

USER $SPTUSER
WORKDIR /home/$SPTUSER

# Github user and passwd
ARG GITUSER
ARG GITPASS

RUN git clone https://$GITUSER:$GITPASS@github.com/SouthPoleTelescope/spt3g_software.git

# Build the spt3g software
RUN cd spt3g_software \
    && mkdir build \
    && cd build \
    && cmake -DPYTHON_EXECUTABLE=`which python3` ..\
    && make
