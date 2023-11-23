#!/bin/bash

set -e -u -x

if [[ ${TRAVIS_OS_NAME:-} == 'linux' ]]; then

    if ${DOCKER:-false} ; then
        echo "Testing in Docker!"
        ./test/docker-build.sh
    else
        echo "Testing in local system!"
        case "${OS}" in
            debian10)
                if ${ANSIBLE:-false} ; then
                    ./test/docker-build-ansible.sh
                else
                    current_dir=${PWD##*/}
                    mv `pwd` /tmp/
                    chmod 755 -R /tmp/$current_dir
                    sudo /tmp/$current_dir/omeroweb-install-debian10-ice${ICEVER}
                fi
                ;;
            ubuntu2004)
                if ${ANSIBLE:-false} ; then
                    ./test/docker-build-ansible.sh
                else
                    current_dir=${PWD##*/}
                    mv `pwd` /tmp/
                    chmod 755 -R /tmp/$current_dir
                    sudo /tmp/$current_dir/omeroweb-install-ubuntu2004-ice${ICEVER}
                fi
                ;;
        esac
    fi

elif [[ ${TRAVIS_OS_NAME} == 'osx' ]]; then

    ./omeroweb-install-osx-ice${ICEVER}

fi