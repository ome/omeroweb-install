#!/bin/bash

set -e -u -x

OMERO_USER=${OMERO_USER:-}

WEBPREFIX=${WEBPREFIX:-}
WEBPORT=${WEBPORT:-80}
WEBSERVER_CONF=${WEBSERVER_CONF:-nginx}

set +u
source $(eval echo ~"${OMERO_USER}")/omerowebvenv/bin/activate
set -u

if [[ $WEBPREFIX = *[!\ ]* ]]; then
    $(eval echo ~"${OMERO_USER}")/OMERO.py/bin/omero config set omero.web.prefix "${WEBPREFIX}"
    $(eval echo ~"${OMERO_USER}")/OMERO.py/bin/omero config set omero.web.static_url "${WEBPREFIX}/static/"
fi

#start-config
$(eval echo ~"${OMERO_USER}")/OMERO.py/bin/omero config set omero.web.application_server wsgi-tcp
$(eval echo ~"${OMERO_USER}")/OMERO.py/bin/omero web config "${WEBSERVER_CONF}" --http "${WEBPORT}" --servername 'localhost' >$(eval echo ~"${OMERO_USER}")/nginx.conf.tmp

cat $(eval echo ~"${OMERO_USER}")/nginx.conf.tmp