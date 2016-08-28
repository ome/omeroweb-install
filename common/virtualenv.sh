#!/bin/bash

set -e -u -x

OMERO_USER=${OMERO_USER:-}

OMEROVER=${OMEROVER:-latest}
ICEVER=${ICEVER:-3.6}

virtualenv $(eval echo ~"${OMERO_USER}")/omerowebvenv
set +u
source $(eval echo ~"${OMERO_USER}")/omerowebvenv/bin/activate
set -u

pip install omego
$(eval echo ~"${OMERO_USER}")/omerowebvenv/bin/omego download --ice $ICEVER --branch $OMEROVER py

zip=$(ls OMERO.py*.zip)
zipname=${zip%.zip}
rm -f $zip
mv $(find . -name 'OMERO.py*' -type d) $(eval echo ~"${OMERO_USER}")/OMERO.py

pip install -r $(eval echo ~"${OMERO_USER}")/OMERO.py/share/web/requirements-py27-trial.txt
