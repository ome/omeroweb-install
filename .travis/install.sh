#!/bin/bash

set -e -u -x

if [[ ${TRAVIS_OS_NAME:-} == 'linux' ]]; then

    if ${DOCKER} ; then
        echo "Testing in Docker!"
        case "${OS}" in
            centos7)
                ./test/docker-build.sh
                ;;
            ubuntu)
                ./test/docker-build.sh
                ;;
        esac
    else
        echo "Testing in local system!"
        case "${OS}" in
            ubuntu)
                if ${ANSIBLE:-} ; then
                    ./test/docker-build-ansible.sh
                else
                    current_dir=${PWD##*/}
                    mv `pwd` /tmp/
                    chmod 755 -R /tmp/$current_dir
                    sudo /tmp/$current_dir/omeroweb-install-ubuntu-ice${ICEVER}
                fi
                ;;
        esac
    fi

else

    ./omeroweb-install-osx-ice${ICEVER}

fi