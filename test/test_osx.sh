#!/bin/bash

set -e -u -x

WEBPORT=${WEBPORT:-80}
WEBPREFIX=${WEBPREFIX:-}

path=`dirname $0`

bash $path/../osx/run

sleep 5

curl -I http://localhost:${WEBPORT}${WEBPREFIX}/webclient/login/

curl -I http://localhost:4080${WEBPREFIX}/webclient/login/
