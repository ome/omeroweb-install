#!/bin/bash

if [[ $TRAVIS_OS_NAME == 'linux' ]]; then

    case "${OS}" in
        centos7)
            ./omeroweb/linux/test/docker-build.sh
            ;;
        ubuntu)
            echo $OS
            ;;
    esac

else

    # Install some custom requirements on OSX
    ./omeroweb/osx/install.sh

fi