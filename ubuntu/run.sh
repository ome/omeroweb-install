#!/bin/bash

set -e -u -x

WEBSESSION=${WEBSESSION:-}

if [[ $WEBSESSION = *[!\ ]* ]]; then
    service redis start
fi

#service crond start # Doesn't work in Docker
cron
service nginx start
service omero-web start
exec bash
