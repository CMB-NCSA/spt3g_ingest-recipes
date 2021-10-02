# Clone locally
#rm -rf spt3g_software
#git clone https://github.com/SouthPoleTelescope/spt3g_software.git

# Build container
export SPTUSER=$USER
export TAG=`date +"%Y%B%d"`
docker build -f centos7/Dockerfile -t menanteau/spt3g_centos7:$TAG --build-arg SPTUSER --rm=true .
docker tag menanteau/spt3g_centos7:$TAG registry.gitlab.com/spt3g/kubernetes/spt-cutter_centos7:$TAG
echo docker push registry.gitlab.com/spt3g/kubernetes/spt-cutter_centos7:$TAG
# Push to gitlab
# docker login registry.gitlab.com
