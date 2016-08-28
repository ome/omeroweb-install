#!/bin/bash

if [[ $TRAVIS_OS_NAME == 'linux' ]]; then

    case "${OS}" in
        centos7)
            ./test/test_services.sh
            ;;
        ubuntu)
            ./linux/ubuntu/run.sh
            ;;
    esac

else

    ./osx/run.sh

    until [ -f ~/OMERO.py/var/django.pid ]; do
      >&2 echo "OMERO.web is unavailable - sleeping"
      sleep 5
    done

    curl -I http://localhost/webclient/login/

fi