#!/bin/bash

set -e -u -x

OMERO_USER=${OMERO_USER:-}

#start-install
apt-get -y install software-properties-common
add-apt-repository -y ppa:nginx/stable
apt-get update
apt-get -y install nginx

#end-install
sed -i.bak -re 's/( default_server.*)/; #\1/' /etc/nginx/nginx.conf
rm /etc/nginx/sites-enabled/default
mv $(eval echo ~"${OMERO_USER}")/nginx.conf.tmp /etc/nginx/conf.d/omeroweb.conf

if [ ! "${container:-}" = docker ]; then
    service nginx start
fi
