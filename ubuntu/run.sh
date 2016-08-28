#!/bin/bash

set -e -u -x

while [[ $# > 1 ]]
do
key="$1"

case $key in
    -w|--websession)
    WEBSESSION="$2"
    shift # past argument
    ;;
    *)
            # unknown option
    ;;
esac
shift # past argument or value
done

service postgresql start
if [[ $WEBSESSION = *[!\ ]* ]]; then
	service redis start
fi
#service crond start # Doesn't work in Docker
cron
service nginx start
service omero-web start
exec bash
