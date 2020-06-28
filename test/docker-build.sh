#!/bin/bash

set -e -u -x

OS=${OS:-centos7}
ICEVER=${ICEVER:-3.6}
WEBPORT=${WEBPORT:-}
WEBPREFIX=${WEBPREFIX:-}
WEBSESSION=${WEBSESSION:-}
WEBSERVER_CONF=${WEBSERVER_CONF:-}
WEBSERVER_NAME=${WEBSERVER_NAME:-}
PYTHONVER=${PYTHONVER:-}

CACHE=${CACHE:---no-cache}

path=`dirname $0`

rm -rf $path/omeroweb-install-test*
mkdir $path/omeroweb-install-test
cp -r $path/../omeroweb-install-${OS}-ice${ICEVER} $path/../${OS}-ice${ICEVER}  $path/omeroweb-install-test
(cd $path && zip -r omeroweb-install-test.zip omeroweb-install-test)
rm -rf $path/omeroweb-install-test

IMAGE=omeroweb_install_test_${OS}_ice${ICEVER}
echo "Building image $IMAGE"

docker build -t ${IMAGE} \
    --build-arg ICEVER=${ICEVER} \
    --build-arg WEBPORT=${WEBPORT} \
    --build-arg WEBPREFIX=${WEBPREFIX} \
    --build-arg WEBSESSION=${WEBSESSION} \
    --build-arg WEBSERVER_CONF=${WEBSERVER_CONF} \
    --build-arg WEBSERVER_NAME=${WEBSERVER_NAME} \
    --build-arg PYTHONVER=${PYTHONVER} \
    ${CACHE} $path -f $path/Dockerfile_$OS
