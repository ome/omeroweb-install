#!/bin/bash

WEBPORT=${WEBPORT:-80}

set +u
source /home/omero/omerowebvenv/bin/activate
set -u

#start-config
/home/omero/OMERO.py/bin/omero config set omero.web.application_server wsgi-tcp
/home/omero/OMERO.py/bin/omero web config nginx --http "$WEBPORT" > /home/omero/nginx.conf.tmp
