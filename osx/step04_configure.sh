#!/bin/bash

set -e -u -x

WEBPORT=${WEBPORT:-80}

set +u
source ~/omerowebvenv/bin/activate
set -u

#start-config
~/OMERO.py/bin/omero config set omero.web.application_server wsgi-tcp
~/OMERO.py/bin/omero web config nginx-development --http $WEBPORT > ~/omeroweb-nginx.conf
