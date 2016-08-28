#!/bin/bash

set -e -u -x

OS=${OS:-centos7}
OMEROVER=${OMEROVER:-latest}
WEBSESSION=${WEBSESSION:-false}
ICEVER=${ICEVER:-3.6}
WEBPORT=${WEBPORT:-80}

path=`dirname $0`

bash $path/step01_init.sh

# install ice
bash $path/$OS/step02_ice_deps.sh
bash $path/$OS/step02_deps.sh


if $WEBSESSION ; then
    bash $path/$OS/step02_deps_websession.sh
fi

su - omero -c "OMEROVER=$OMEROVER bash $path/step03_virtualenv.sh"

su - omero -c "WEBPORT=$WEBPORT bash $path/step04_configure.sh"

if $WEBSESSION ; then
    su - omero -c "bash $path/step04_websessionconfig.sh"
fi

bash $path/$OS/step05_nginx.sh

bash $path/$OS/step06_selinux.sh

bash $path/$OS/step07_daemon.sh

