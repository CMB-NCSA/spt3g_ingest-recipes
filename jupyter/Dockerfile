
FROM jupyter/scipy-notebook:python-3.8.8

USER root
RUN apt-get update

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata
RUN apt-get install -y wget emacs git
# Pre-reqs from:
# https://southpoletelescope.github.io/spt3g_software/quickstart.html
RUN apt-get install -y build-essential
RUN apt-get install -y cmake libboost-all-dev libflac-dev libnetcdf-dev libfftw3-dev libgsl0-dev
RUN apt-get install -y hdf5-tools hdf5-helpers

# Get back into the jupyter environment
ENV CONDA_DIR=/opt/conda SHELL=/bin/bash NB_USER=jovyan NB_UID=1000 NB_GID=100 LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8
ENV PATH=/opt/conda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin HOME=/home/jovyan

# Python extras for spt3g_software
RUN conda install -y fitsio astropy pandas yaml healpy numexpr
RUN conda install -y boost boost-cpp
RUN conda install -y -c main py-boost

COPY spt3g_software /opt/spt/spt3g_software
WORKDIR /opt/spt

# Build the spt3g software
RUN cd spt3g_software \
    && mkdir build \
    && cd build \
    && cmake ..\
    && make \
    && ./env-shell.sh make docs

COPY ubuntu/setSPTEnv.sh /opt/spt/setSPTEnv.sh

# more ENV for SPT3G
ENV SPT3G_SOFTWARE_PATH /opt/spt/spt3g_software
ENV SPT3G_SOFTWARE_BUILD_PATH /opt/spt/spt3g_software/build
ENV SPT3G_BUILD_ROOT ${SPT3G_SOFTWARE_BUILD_PATH}
ENV PATH ${SPT3G_BUILD_ROOT}/bin:$PATH
ENV LD_LIBRARY_PATH ${SPT3G_BUILD_ROOT}/spt3g:$LD_LIBRARY_PATH
ENV PYTHONPATH ${SPT3G_BUILD_ROOT}:$PYTHONPATH

# Install the spt3g_cutter
RUN conda install -y -c conda-forge esutil pyaml-env
ARG SPT3G_CUTTER_VERSION
WORKDIR /tmp
RUN git clone https://github.com/CMB-NCSA/spt3g_cutter -b $SPT3G_CUTTER_VERSION && \
    cd spt3g_cutter &&\
    python setup.py install

# Install spt3g_ingest
RUN conda install -y -c conda-forge python-magic
ARG SPT3G_INGEST_VERSION
RUN git clone https://github.com/CMB-NCSA/spt3g_ingest -b $SPT3G_INGEST_VERSION && \
    cd spt3g_ingest && \
    python setup.py install

# Get back into the jupyter environment
ARG NB_USER=jovyan
ARG NB_UID=1000
ARG NB_GID=100
#SHELL [/bin/bash -o pipefail -c]
ENV CONDA_DIR=/opt/conda SHELL=/bin/bash NB_USER=jovyan NB_UID=1000 NB_GID=100 LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8
ENV PATH=/opt/conda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin HOME=/home/jovyan
USER 1000
WORKDIR /home/jovyan

# Start with the right environment
ENTRYPOINT ["sh", "/opt/spt/setSPTEnv.sh"]
