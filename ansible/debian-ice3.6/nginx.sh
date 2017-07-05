#!/bin/bash

set -e -u -x

#start-install
apt-get update
apt-get -y install nginx

#end-install
sed -i.bak -re 's/( default_server.*)/; #\1/' /etc/nginx/nginx.conf
mv /etc/nginx/sites-available/default /etc/nginx/sites-available/default.disabled
cp /home/omero/nginx.conf.tmp /etc/nginx/conf.d/omeroweb.conf

if [ ! "${container:-}" = docker ]; then
    service nginx restart
fi
