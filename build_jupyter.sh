cd spt3g_software
SPT3G_REV=`git rev-parse --short HEAD`
cd ../

# Build container
export DISTRO=jupyter
export IMAGE_REPO=registry.gitlab.com/spt3g/kubernetes/spt3g_jupyter
export SPT3G_INGEST_VERSION=0.2.8
export SPT3G_CUTTER_VERSION=0.3.0
export TAG=${SPT3G_REV}_${SPT3G_INGEST_VERSION}_${SPT3G_CUTTER_VERSION}
docker build -f $DISTRO/Dockerfile \
       --build-arg SPT3G_INGEST_VERSION \
       --build-arg SPT3G_CUTTER_VERSION \
       -t $IMAGE_REPO:$TAG \
       --rm=true .
