#!/bin/bash

if [[ $TRAVIS_OS_NAME == 'linux' ]]; then

    if [ "$DOCKER" = true ] ; then
        echo "Testing in Docker"
        case "${OS}" in
            centos7)
                ./test/docker-build.sh
                ;;
            ubuntu)
                ./test/docker-build.sh
                ;;
        esac
    else
        echo "Testing in VM"
        case "${OS}" in
            ubuntu)

                current_dir=${PWD##*/}
                mv `pwd` /tmp/
                chmod 755 -R /tmp/$current_dir

                sudo /tmp/$current_dir/omeroweb-install-ubuntu
                exit
                ;;
        esac
    fi

else

    ./omeroweb-install-osx

fi