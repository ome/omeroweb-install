#!/bin/bash

set -e -u -x
if [ -z "$(getent passwd omero)" ]; then

    useradd -m omero

fi

chmod a+X /home/omero
