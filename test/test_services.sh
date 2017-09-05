#!/bin/bash

set -e -u -x

OS=${OS:-centos7}
OMEROVER=${OMEROVER:-latest}
WEBSESSION=${WEBSESSION:-}
WEBPREFIX=${WEBPREFIX:-}
WEBPORT=${WEBPORT:-80}
ICEVER=${ICEVER:-3.6}

CNAME=omeroweb_install_test_${OS}_ice${ICEVER}

# start docker container
if [[ "darwin" == "${OSTYPE//[0-9.]/}" ]]; then
    docker run -d --privileged -p 8888:${WEBPORT} --name $CNAME $CNAME
else
    docker run -d --name $CNAME -v /sys/fs/cgroup:/sys/fs/cgroup:ro -v /run $CNAME
fi

sleep 5

# check if container is running
docker inspect -f {{.State.Running}} $CNAME

docker logs $CNAME

# Log in to OMERO.web
if [[ "darwin" == "${OSTYPE//[0-9.]/}" ]]; then
  curl -f -I http://localhost:8888${WEBPREFIX}/webclient/login/
else
  DOCKER_IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' $CNAME)
  curl -f -I http://${DOCKER_IP}:${WEBPORT}${WEBPREFIX}/webclient/login/
fi



# stop and cleanup
docker stop $CNAME
docker rm $CNAME
