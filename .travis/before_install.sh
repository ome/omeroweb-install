#!/bin/bash

if [[ $TRAVIS_OS_NAME == 'linux' ]]; then

    sudo apt-get update
    sudo DEBIAN_FRONTEND=noninteractive apt-get install -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" docker-engine
    sudo apt-get -y install shunit2

    pip install -r requirements.txt

else

    brew update
    sudo easy_install pip
    sudo pip install -r requirements.txt

fi
