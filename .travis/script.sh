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


    OMERO_USER=${OMERO_USER:-}
    HOME_DIR=$(eval echo ~"$OMERO_USER")

    ./run.sh

    until [ -f ${HOME_DIR}/OMERO.py/var/django.pid ]; do
      >&2 echo "OMERO.web is unavailable - sleeping"
      sleep 5
    done

    curl -I http://localhost/webclient/login/

fi