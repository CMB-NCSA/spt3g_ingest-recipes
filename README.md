# spt3g_docker
Docker recipes for SPT-3G Science codes.

# To build:
```
# Clone locally
rm -rf spt3g_software
git clone https://github.com/SouthPoleTelescope/spt3g_software.git

# Build container
export SPTUSER=$USER
export TAG=`date +"%Y%B%d"`
docker build -t spt3g_ubuntu:$TAG --build-arg SPTUSER --rm=true .
```
