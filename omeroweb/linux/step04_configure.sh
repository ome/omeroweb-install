#!/bin/bash

WEBPORT=${WEBPORT:-80}

set +u
source ~omero/omerowebvenv/bin/activate
set -u

#start-config
~omero/OMERO.py/bin/omero config set omero.web.application_server wsgi-tcp
~omero/OMERO.py/bin/omero web config nginx --http "$WEBPORT" > ~omero/nginx.conf.tmp
