#!/bin/bash

set -e -u -x

WEBPREFIX=${WEBPREFIX:-}
WEBPORT=${WEBPORT:-80}
WEBSERVER_NAME=${WEBSERVER_NAME:-localhost}

set +u
source /home/omero/omerowebvenv/bin/activate
set -u
if [[ $WEBPREFIX = *[!\ ]* ]]; then
    /home/omero/OMERO.py/bin/omero config set omero.web.prefix "${WEBPREFIX}"
    /home/omero/OMERO.py/bin/omero config set omero.web.static_url "${WEBPREFIX}/static/"
fi

/home/omero/OMERO.py/bin/omero config set omero.web.application_server wsgi-tcp
/home/omero/OMERO.py/bin/omero web config nginx --http "${WEBPORT}" --servername "${WEBSERVER_NAME}" > /home/omero/nginx.conf.tmp

cat /home/omero/nginx.conf.tmp
