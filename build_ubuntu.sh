# Clone locally
#rm -rf spt3g_software
#git clone https://github.com/SouthPoleTelescope/spt3g_software.git

# Build container
export SPTUSER=$USER
export TAG=`date +"%Y%B%d"`
docker build -f ubuntu/Dockerfile -t menanteau/spt3g_centos7:$TAG --build-arg SPTUSER --rm=true .
