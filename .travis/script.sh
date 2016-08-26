#!/bin/bash

if [[ $TRAVIS_OS_NAME == 'linux' ]]; then

    case "${OS}" in
        centos7)
            ./omeroweb/linux/test/test_services.sh
            ;;
        ubuntu)
            echo $OS
            ;;
    esac

else

    ./omeroweb/osx/run.sh

    until [ -f ~/OMERO.py/var/django.pid ]; do
      >&2 echo "OMERO.web is unavailable - sleeping"
      sleep 5
    done

    curl -I http://localhost/webclient/login/

fi