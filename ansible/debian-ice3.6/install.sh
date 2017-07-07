#!/bin/bash

set -e -u -x

OMEROVER=${OMEROVER:-OMERO-DEV-latest}


/home/omero/omerowebvenv/bin/omego download --ice "3.6" --branch "${OMEROVER}" py

zip=$(ls OMERO.py*.zip)
rm -f $zip
if [ ! -d "/home/omero/OMERO.py" ]; then
    mv $(find . -name 'OMERO.py*' -type d) /home/omero/OMERO.py
fi

