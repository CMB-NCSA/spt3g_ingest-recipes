# Clone locally
# rm -rf spt3g_software
# git clone https://github.com/SouthPoleTelescope/spt3g_software.git
cd spt3g_software
SPT3G_REV=`git rev-parse --short HEAD`
cd ../

# Build container
export DISTRO=ubuntu
export IMAGE=spt3g_ingest
export SPTUSER=$USER
#export TAG=`date +"%Y%B%d"`
export SPT3G_INGEST_VERSION=0.5.1
export TAG=${DISTRO}_${SPT3G_INGEST_VERSION}_${SPT3G_REV}
docker build -f $DISTRO/Dockerfile \
       -t menanteau/$IMAGE:$TAG \
       --build-arg SPT3G_INGEST_VERSION \
       --build-arg SPTUSER \
       --rm=true .

echo 'Push commands:'
echo "   docker push menanteau/$IMAGE:${TAG}"

echo 'To create singularity image:'
echo "  ./docker2singularity menanteau/$IMAGE:${TAG}"
