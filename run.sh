#!/bin/bash

set -e -u -x

OMERO_USER=${OMERO_USER:-}


OS=${OS:-centos7}
OMEROVER=${OMEROVER:-latest}
WEBSESSION=${WEBSESSION:-}
ICEVER=${ICEVER:-3.6}
WEBPORT=${WEBPORT:-80}


path=`dirname $0`

if [ -f $path/$OS/run.sh ]
then
    bash $path/$OS/run.sh
fi
