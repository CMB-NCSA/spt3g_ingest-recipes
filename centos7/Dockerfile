FROM centos:7

RUN yum -y update

RUN yum -y install epel-release
RUN yum -y install wget git fftw fftw-devel gsl gsl-devel gcc-c++  libicu-devel libicu icu
RUN yum -y install which make python3-devel openssl-devel openssl cfitsio
RUN yum -y install flac netcdf flac-devel netcdf-devel

RUN cd /usr/local/src/ \
    && curl -o get-pip.py https://bootstrap.pypa.io/get-pip.py  \
    && chmod 755 ./get-pip.py \
    && python3 ./get-pip.py

RUN  pip3 install scipy astropy numexpr healpy pyyaml sphinx

RUN cd /usr/local/src/ \
    && mkdir boost \
    && cd boost \
    && curl -o boost_1_72_0.tar.gz http://deslogin.cosmology.illinois.edu/~daues/boost_1_72_0.tar.gz \
    && gunzip boost_1_72_0.tar.gz \
    && tar -xf boost_1_72_0.tar  \
    && cd boost_1_72_0 \
    && CPLUS_INCLUDE_PATH=/usr/include/python3.6m/ ./bootstrap.sh  --with-python=python3 \
    && CPLUS_INCLUDE_PATH=/usr/include/python3.6m/ ./b2 install

RUN cd /usr/local/src/  \
    && mkdir cmake  \
    && cd cmake \
    && curl -o cmake-3.19.5.tar.gz http://deslogin.cosmology.illinois.edu/~daues/cmake-3.19.5.tar.gz \
    && gunzip cmake-3.19.5.tar.gz  \
    && tar -xf cmake-3.19.5.tar  \
    && cd cmake-3.19.5 \
    && ./configure --prefix=/usr/local \
    && make \
    && make install


# Build the spt3g software
COPY spt3g_software /opt/spt/spt3g_software
WORKDIR /opt/spt
RUN cd spt3g_software \
    && mkdir build \
    && cd build \
    && cmake ..\
    && make \
    && ./env-shell.sh make docs


#RUN mkdir -p /opt/spt  \
#    && cd /opt/spt \
#    && curl -o spt3g-0.3.7f694cb.tar.gz http://deslogin.cosmology.illinois.edu/~daues/spt3g-0.3.7f694cb.tar.gz \
#    && gunzip spt3g-0.3.7f694cb.tar.gz  \
#    && tar -xf  spt3g-0.3.7f694cb.tar \
#    && cd spt3g_software  \
#    && mkdir build  \
#    && cd build \
#    && cmake .. \
#    && make
