#!/bin/bash

set -e -u -x

OS=${OS:-centos7}

CACHE=${CACHE:---no-cache}

path=`dirname $0`

rm -rf $path/omeroweb-install-test
mkdir $path/omeroweb-install-test
cp -r $path/../omeroweb-install-$OS $path/../$OS  $path/omeroweb-install-test
(cd $path && zip -r omeroweb-install-test.zip omeroweb-install-test)
rm -rf $path/omeroweb-install-test

IMAGE=omeroweb_install_test_$OS
echo "Building image $IMAGE"

docker build -t ${IMAGE} ${CACHE} $path -f $path/Dockerfile_$OS
