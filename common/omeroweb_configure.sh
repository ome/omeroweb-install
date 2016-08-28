#!/bin/bash

set -e -u -x

OMERO_USER=${OMERO_USER:-}

WEBPORT=${WEBPORT:-80}

set +u
source $(eval echo ~"${OMERO_USER}")/omerowebvenv/bin/activate
set -u

#start-config
$(eval echo ~"${OMERO_USER}")/OMERO.py/bin/omero config set omero.web.application_server wsgi-tcp
$(eval echo ~"${OMERO_USER}")/OMERO.py/bin/omero web config nginx --http "$WEBPORT" >$(eval echo ~"${OMERO_USER}")/nginx.conf.tmp

cat $(eval echo ~"${OMERO_USER}")/nginx.conf.tmp