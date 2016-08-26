#!/bin/bash

set -e -u -x

ENV=${ENV:-centos7}
DMNAME=${DMNAME:-dev}
WEBSESSION=${WEBSESSION:-false}

CNAME=omeroweb_install_test_$ENV

# start docker container
if [[ "darwin" == "${OSTYPE//[0-9.]/}" ]]; then
    docker run -d --privileged -p 8888:80 --name $CNAME $CNAME
else
    docker run -d --name $CNAME -v /sys/fs/cgroup:/sys/fs/cgroup:ro -v /run omero_install_test_$ENV
fi

# check if container is running
docker inspect -f {{.State.Running}} $CNAME

# stop and cleanup
docker stop $CNAME
docker rm $CNAME
