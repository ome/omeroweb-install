#!/bin/bash

set -e -u -x

#start-recommended
cp `dirname $0`/omero-web-init.d /etc/init.d/omero-web
chmod a+x /etc/init.d/omero-web

update-rc.d -f omero-web remove
update-rc.d -f omero-web defaults 98 02
#end-recommended