# Clone locally
rm -rf spt3g_software
git clone https://github.com/SouthPoleTelescope/spt3g_software.git

# Build container
export SPTUSER=$USER
docker build -t spt3g_ubuntu --build-arg SPTUSER --rm=true .
