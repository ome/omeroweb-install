#!/bin/bash

if [[ $TRAVIS_OS_NAME == 'linux' ]]; then

    if [ "$DOCKER" = true ] ; then
        echo "Testing in Docker"
        case "${OS}" in
            centos7)
                ./test/test_services.sh
                ;;
            ubuntu)
                ./test/test_services.sh
                ;;
        esac
    else
        echo "Testing in VM"
        case "${OS}" in
            ubuntu)
                /tmp/omeroweb-install/ubuntu/run
                ;;
        esac
    fi
else

  ./test/test_web.sh

fi