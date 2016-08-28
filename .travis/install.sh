#!/bin/bash

if [[ $TRAVIS_OS_NAME == 'linux' ]]; then

    case "${OS}" in
        centos7)
            ./test/docker-build.sh
            ;;
        ubuntu)
            ./linux/install.sh
            ;;
    esac

else

    # Install some custom requirements on OSX
    ./osx/install.sh

fi