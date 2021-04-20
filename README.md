# spt3g_docker
Docker recipes for SPT-3G Science codes.

# To build:
```
export GITUSER=your_git_user
export GITPASS=your_git_passwd
docker build -t spt3g_centos7 --build-arg GITUSER --build-arg GITPASS --rm=true .
```
