# To build:
# export SPTUSER=$USER
# docker build -t spt3g_ubuntu --build-arg SPTUSER --rm=true .

# To start:
# hostname="`hostname -s`-docker"
# DOCKER_IMA=spt3g_ubuntu:latest
# docker run -ti -h $hostname -v $HOME/SPT-3G/home-spt3g:/home/$SPTUSER $DOCKER_IMA bash

# Clean up:
# docker rm $(docker ps -a -q)

# Older ubuntu version
# FROM ubuntu:20.04
# Latest version
FROM ubuntu:24.04

RUN apt-get update --fix-missing
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata
RUN apt-get update --fix-missing
RUN apt-get install -y wget emacs git
# Pre-reqs from:
# https://southpoletelescope.github.io/spt3g_software/quickstart.html
RUN apt-get install -y cmake libboost-all-dev libflac-dev libnetcdf-dev libfftw3-dev libgsl0-dev

# Astropy/numpy/scipy
#RUN apt-get install -y python3-numpy python3-scipy python3-astropy python3-sphinx
#RUN apt-get install -y python3-sphinx
#RUN apt-get install -y python3-numexpr python3-healpy ipython3
#RUN apt-get install -y python3-fitsio python3-yaml python3-pandas python-is-python3
#RUN apt-get install -y python3-magic screen time
RUN apt-get install -y hdf5-tools hdf5-helpers
RUN apt-get install -y screen time
RUN apt-get install -y python-is-python3
RUN apt-get install -y python3-healpy python3-fitsio python3-pandas python3-yaml python3-magic python3-sphinx python3-matplotlib
# This trick install distutils under the hood
RUN apt-get install -y python3-pip

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

# Temporarily fix for the galaxy ptsrc list
RUN cd /opt/spt/spt3g_software/sources/python/mask_lists && \
    ln -s galaxy_ptsrc_mask_list.txt galaxy_ptsrc_list_2023.txt

# Git clone and version checkout and install of spt3g_ingest
ARG SPT3G_INGEST_VERSION
RUN echo "This is the version:" $SPT3G_INGEST_VERSION
RUN git clone https://github.com/CMB-NCSA/spt3g_ingest -b $SPT3G_INGEST_VERSION && \
    cd spt3g_ingest && \
    python setup.py install

# Add $SPTUSER as user and create groups wheel and spt
ARG SPTUSER
RUN useradd -ms /bin/bash -u 47448 $SPTUSER && \
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

COPY ubuntu/setSPTEnv.sh /opt/spt/setSPTEnv.sh

# more ENV
ENV SPT3G_SOFTWARE_PATH /opt/spt/spt3g_software
ENV SPT3G_SOFTWARE_BUILD_PATH /opt/spt/spt3g_software/build
ENV SPT3G_BUILD_ROOT ${SPT3G_SOFTWARE_BUILD_PATH}
ENV PATH ${SPT3G_BUILD_ROOT}/bin:$PATH
ENV LD_LIBRARY_PATH ${SPT3G_BUILD_ROOT}/lib:$LD_LIBRARY_PATH
ENV PYTHONPATH ${SPT3G_BUILD_ROOT}:$PYTHONPATH

USER $SPTUSER
WORKDIR /home/$SPTUSER

# Start with the right miniconda environment
RUN cat /opt/spt/setSPTEnv.sh >> $HOME/.bashrc

# Start with the right environment
#ENTRYPOINT ["/bin/bash", "/opt/spt/setSPTEnv.sh"]
