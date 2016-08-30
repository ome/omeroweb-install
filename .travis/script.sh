#!/bin/bash

set -e -u -x

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
        echo "Testing installation only in VM"
        echo "cron is failing with: 'cron: can't lock /var/run/crond.pid, otherpid may be 1474: Resource temporarily unavailable'"
    fi
else

  ./test/test_web.sh

fi