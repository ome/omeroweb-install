#!/bin/bash

set -e -u -x

if [[ ${TRAVIS_OS_NAME:-} == 'linux' ]]; then

    if ${DOCKER:-false} ; then
        echo "Testing in Docker"
        ./test/test_services.sh
    else
        echo "Testing in VM"
        if [[ ! ${OS} =~ "centos" ]];  then
            if ${ANSIBLE:-false} ; then
                (cd test && ./test_ansible.sh)
            else
                echo "Testing installation only in VM"
                echo "cron is failing with: 'cron: can't lock /var/run/crond.pid, otherpid may be 1474: Resource temporarily unavailable'"
            fi
        fi
    fi

elif [[ ${TRAVIS_OS_NAME} == 'osx' ]]; then

  ./test/test_web.sh

fi