#!/usr/bin/env bash
# Start up OMERO.web and nginx server

set -e -u -x

OMERO_USER=${OMERO_USER:-}

set +u
source $(eval echo ~"${OMERO_USER}")/omerowebvenv/bin/activate
set -u

# Start OMERO.web
$(eval echo ~"${OMERO_USER}")/OMERO.py/bin/omero web start

# Start webserver
sudo nginx -c $(eval echo ~"${OMERO_USER}")/omeroweb-nginx.conf
