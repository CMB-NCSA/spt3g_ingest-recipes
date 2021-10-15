# Build container
export SPTUSER=$USER
export MINICONDA_PATH=/opt/miniconda3
#export TAG=`date +"%Y%B%d"`
export TAG=dev
export IMAGE=spt-cutter
docker build -f $IMAGE/Dockerfile -t menanteau/$IMAGE:$TAG --build-arg SPTUSER --build-arg MINICONDA_PATH --rm=true .


#docker tag menanteau/$IMAGE:$TAG registry.gitlab.com/spt3g/kubernetes/$IMAGE:$TAG
#echo "Push commands:"
#echo "   docker pysh menanteau/$IMAGE:${TAG}"
#echo "   docker push registry.gitlab.com/spt3g/kubernetes/$IMAGE:${TAG}"
# Push to gitlab
# docker login registry.gitlab.com
