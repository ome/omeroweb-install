#!/bin/bash

if [[ $TRAVIS_OS_NAME == 'linux' ]]; then

    case "${OS}" in
        centos7)
            ./omeroweb/test/docker-build.sh
            ;;
        ubuntu)
            ./omeroweb/linux/install.sh
            ;;
    esac

else

    # Install some custom requirements on OSX
    ./omeroweb/osx/install.sh

fi