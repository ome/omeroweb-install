#!/bin/bash

if [[ $TRAVIS_OS_NAME == 'linux' ]]; then

    case "${OS}" in
        centos7)
            sudo apt-get update
            sudo DEBIAN_FRONTEND=noninteractive apt-get install -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" docker-engine
            sudo apt-get -y install shunit2
            ;;
        ubuntu)
            sudo apt-get update
            sudo DEBIAN_FRONTEND=noninteractive apt-get install -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" docker-engine
            sudo apt-get -y install shunit2
            ;;
    esac

else

    brew update

fi