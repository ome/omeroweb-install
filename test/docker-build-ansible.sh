#!/bin/bash

set -e -u -x

OS=${OS:-rockylinux9}
ICEVER=${ICEVER:-3.6}

WEBPREFIX=${WEBPREFIX:-}
WEBPORT=${WEBPORT:-80}
WEBSERVER_NAME=${WEBSERVER_NAME:-localhost}
WEBSERVER_CONF=${WEBSERVER_CONF:-nginx}
PYTHONVER=${PYTHONVER:-}

CACHE=${CACHE:---no-cache}

path=`dirname $0`

IMAGE=omeroweb_install_test_ansible_${OS}_ice${ICEVER}

echo "Building image $IMAGE"

docker build -t ${IMAGE} ${CACHE} $path -f $path/Dockerfile_${OS}_ansible
