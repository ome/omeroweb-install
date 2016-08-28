#!/bin/bash

set -e -u -x

OMEROVER=${OMEROVER:-latest}
ICEVER=${ICEVER:-3.6}

virtualenv ~/omerowebvenv
set +u
source ~/omerowebvenv/bin/activate
set -u

pip install omego
~/omerowebvenv/bin/omego download --ice $ICEVER --branch $OMEROVER py

zip=$(ls OMERO.py*.zip)
zipname=${zip%.zip}
rm -f $zip
mv $(find . -name 'OMERO.py*' -type d) ~/OMERO.py

pip install -r ~/OMERO.py/share/web/requirements-py27-trial.txt
