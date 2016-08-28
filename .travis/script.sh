#!/bin/bash

if [[ $TRAVIS_OS_NAME == 'linux' ]]; then

    case "${OS}" in
        centos7)
            ./test/test_services.sh
            ;;
        ubuntu)
            ./test/test_services.sh
            #./linux/ubuntu/run.sh
            ;;
    esac

else

    ./test/test_osx.sh

fi