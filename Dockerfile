# To build:
# GITUSER=menanteau
# docker build -t spt3g_centos7 --build-arg GITUSER --build-arg GITPASS --rm=true .

# Clean up:
# docker rm $(docker ps -a -q)
FROM centos:7

# Github user and passwd
ARG GITUSER
ARG GITPASS

# SPT-3G pre-reqs from:
# https://southpoletelescope.github.io/spt3g_software/quickstart.html#how-to-install
RUN yum -y install cmake netcdf-devel boost-devel flac-devel fftw-devel gsl-devel

# Other extras
RUN yum -y install emacs wget git patch make

# Install cmake3/hdf5/netcdf
RUN yum -y install epel-release
RUN yum -y install cmake3 hdf5 hdf5-devel netcdf netcdf-devel
RUN yum -y install python-astropy ipython
RUN yum -y install gcc-c++ gcc.x86_64 gcc-gfortran

RUN git clone https://$GITUSER:$GITPASS@github.com/SouthPoleTelescope/spt3g_software.git

# Build the spt3g software
RUN cd spt3g_software \
    && mkdir build \
    && cd build \
    && cmake3 .. \
    && make
