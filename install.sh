#!/bin/bash

set -e -u -x

OMERO_USER=${OMERO_USER:-}

OS=${OS:-centos7}
OMEROVER=${OMEROVER:-latest}
WEBSESSION=${WEBSESSION:-}
ICEVER=${ICEVER:-3.6}
WEBPORT=${WEBPORT:-80}


path=`dirname $0`

if [ -f $path/common/create_user.sh ]
then
    bash $path/common/create_user.sh
fi

# install ice
if [ -f $path/$OS/deps_ice.sh ]
then
    bash $path/$OS/deps_ice.sh
fi

bash $path/$OS/deps.sh


if [[ $WEBSESSION = *[!\ ]* ]]; then
    bash $path/$OS/deps_websession.sh
fi

if [[ $OMERO_USER = *[!\ ]* ]]; then
    su - ${OMERO_USER}  -c "OMERO_USER=$OMERO_USER ICEVER=$ICEVER OMEROVER=$OMEROVER bash $path/common/virtualenv.sh"
    su - ${OMERO_USER}  -c "OMERO_USER=$OMERO_USER WEBPORT=$WEBPORT bash $path/common/omeroweb_configure.sh"
else
    bash $path/common/virtualenv.sh
    bash $path/common/omeroweb_configure.sh
fi

if [[ $WEBSESSION = *[!\ ]* ]]; then
    if [[ $OMERO_USER = *[!\ ]* ]]; then
        su - ${OMERO_USER}  -c "OMERO_USER=$OMERO_USER bash $path/common/websession_configure.sh"
    else
        bash $path/common/websession_configure.sh
    fi
fi

if [ -f $path/$OS/nginx.sh ]
then
    bash $path/$OS/nginx.sh
fi

if [ -f $path/$OS/selinux.sh ]
then
    bash $path/$OS/selinux.sh
fi

if [ -f $path/$OS/daemon.sh ]
then
    bash $path/$OS/daemon.sh
fi
