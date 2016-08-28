#!/bin/bash

set -e -u -x

OMERO_USER=${OMERO_USER:-}

brew install nginx

mv $(eval echo ~"${OMERO_USER}")/nginx.conf.tmp /usr/local/etc/nginx/servers/omeroweb-nginx.conf

# Restart webserver
brew services restart nginx