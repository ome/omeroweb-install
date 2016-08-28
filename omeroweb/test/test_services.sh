#!/bin/bash

set -e -u -x

OS=${OS:-centos7}
OMEROVER=${OMEROVER:-latest}
WEBSESSION=${WEBSESSION:-false}
ICEVER=${ICEVER:-3.6}
WEBPORT=${WEBPORT:-80}


CNAME=omeroweb_install_test_$OS

# start docker container
if [[ "darwin" == "${OSTYPE//[0-9.]/}" ]]; then
    docker run -d --privileged -p 8888:80 --name $CNAME $CNAME
else
    docker run -d --name $CNAME -v /sys/fs/cgroup:/sys/fs/cgroup:ro -v /run $CNAME
fi

# check if container is running
docker inspect -f {{.State.Running}} $CNAME

# stop and cleanup
docker stop $CNAME
docker rm $CNAME
