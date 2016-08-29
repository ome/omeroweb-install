#!/bin/bash

if [[ $TRAVIS_OS_NAME == 'linux' ]]; then

    sudo apt-get update
    sudo DEBIAN_FRONTEND=noninteractive apt-get install -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" docker-engine
    sudo apt-get -y install shunit2

else

    brew update
    sudo easy_install pip

fi

pip install -r requirements.txt
