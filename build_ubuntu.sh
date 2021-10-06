# Clone locally
#rm -rf spt3g_software
#git clone https://github.com/SouthPoleTelescope/spt3g_software.git

# Build container
export SPTUSER=$USER
export TAG=`date +"%Y%B%d"`
docker build -f ubuntu/Dockerfile -t menanteau/spt3g_ubuntu:$TAG --build-arg SPTUSER --rm=true .
# Re-tag name
docker tag menanteau/spt3g_ubuntu:$TAG registry.gitlab.com/spt3g/kubernetes/spt-cutter:$TAG
echo 'Push commands:'
echo '   docker push menanteau/spt3g_ubuntu:$TAG'
echo '   docker push registry.gitlab.com/spt3g/kubernetes/spt-cutter:$TAG'
# Push to gitlab
# docker login registry.gitlab.com
