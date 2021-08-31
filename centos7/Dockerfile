FROM centos:7

RUN yum -y update

RUN yum install -y centos-release-scl yum-utils
RUN yum install -y devtoolset-9

RUN yum -y install epel-release
RUN yum -y install wget git fftw fftw-devel gsl gsl-devel gcc-c++  libicu-devel libicu icu
RUN yum -y install which make python3-devel openssl-devel openssl cfitsio bzip2 bzip2-devel
RUN yum -y install flac netcdf flac-devel netcdf-devel

SHELL [ "/usr/bin/scl", "enable", "devtoolset-9" ]

RUN cd /usr/local/src/ \
    && curl -o get-pip.py https://bootstrap.pypa.io/get-pip.py  \
    && chmod 755 ./get-pip.py \
    && python3 ./get-pip.py

RUN  pip3 install scipy astropy numexpr healpy pyyaml sphinx

RUN cd /usr/local/src/ \
    && mkdir boost \
    && cd boost \
    && curl -L -o boost_1_72_0.tar.gz https://sourceforge.net/projects/boost/files/boost/1.72.0/boost_1_72_0.tar.gz \
    && gunzip boost_1_72_0.tar.gz \
    && tar -xf boost_1_72_0.tar  \
    && cd boost_1_72_0 \
    && CPLUS_INCLUDE_PATH=/usr/include/python3.6m/ ./bootstrap.sh  --with-python=python3 \
    && CPLUS_INCLUDE_PATH=/usr/include/python3.6m/ ./b2 install

RUN cd /usr/local/src/  \
    && mkdir cmake  \
    && cd cmake \
    && curl -L -o ./cmake-3.19.5.tar.gz https://github.com/Kitware/CMake/releases/download/v3.19.5/cmake-3.19.5.tar.gz \
    && gunzip cmake-3.19.5.tar.gz  \
    && tar -xf cmake-3.19.5.tar  \
    && cd cmake-3.19.5 \
    && ./configure --prefix=/usr/local \
    && make \
    && make install

# RUN mkdir -p /opt/spt  \
RUN mkdir -p /opt/spt

# Build the spt3g software
COPY spt3g_software /opt/spt/spt3g_software
WORKDIR /opt/spt
RUN cd spt3g_software \
    && mkdir build \
    && cd build \
    && cmake ..\
    && make \
    && ./env-shell.sh make docs

# Add $SPTUSER as user and create groups wheel and spt
ARG SPTUSER
RUN adduser --shell /bin/bash -u 1001 $SPTUSER && \
    groupadd --gid 1003 spt

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
