#!/bin/bash

if [[ $TRAVIS_OS_NAME == 'osx' ]]; then

    brew update

else

    sudo apt-get update
    sudo DEBIAN_FRONTEND=noninteractive apt-get install -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" docker-engine
    sudo apt-get -y install shunit2

fi