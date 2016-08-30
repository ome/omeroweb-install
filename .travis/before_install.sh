#!/bin/bash

set -e -u -x

if [[ $TRAVIS_OS_NAME == 'linux' ]]; then

    if [ ${DOCKER} = true ] ; then
        echo "Installing Docker"
        sudo apt-get update
        sudo DEBIAN_FRONTEND=noninteractive apt-get install -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" docker-engine
        sudo apt-get -y install shunit2
    fi

    sudo pip install -r requirements.txt

else

    brew update
    sudo easy_install pip
    sudo pip install -r requirements.txt

fi

./build --os=${OS} --omero-version=${OMEROVER:-} --ice-version=${ICEVER:-} web-prefix=${WEBPREFIX:-} web-port=${WEBPORT:-} web-server-conf=${WEBSERVER_CONF:-} web-server-name=${WEBSERVER_NAME:-}
