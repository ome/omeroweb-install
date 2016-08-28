#!/bin/bash

set -e -u -x

OS=${OS:-centos7}
OMEROVER=${OMEROVER:-latest}
WEBSESSION=${WEBSESSION:-false}
ICEVER=${ICEVER:-3.6}
WEBPORT=${WEBPORT:-80}

path=`dirname $0`

#bash $path/step01_init.sh

bash $path/step02_deps.sh


if $WEBSESSION ; then
    bash $path/step02_deps_websession.sh
fi

bash $path/step03_virtualenv.sh

bash $path/step04_configure.sh

if $WEBSESSION ; then
    bash $path/step04_websessionconfig.sh
fi

bash $path/step05_nginx.sh
