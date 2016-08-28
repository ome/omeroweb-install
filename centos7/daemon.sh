#!/bin/bash

set -e -u -x

#start-recommended
cp `dirname $0`/omero-web-systemd.service /etc/systemd/system/omero-web.service

if [ ! "${container:-}" = docker ]; then
    systemctl daemon-reload
fi

systemctl enable omero-web.service
#end-recommended