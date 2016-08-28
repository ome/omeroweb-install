#!/bin/bash

if [[ $TRAVIS_OS_NAME == 'linux' ]]; then

    case "${OS}" in
        centos7)
            ./test/docker-build.sh
            ;;
        ubuntu)
            ./test/docker-build.sh
            #sudo ./linux/install.sh
            ;;
    esac

else

    ./osx/install.sh

fi