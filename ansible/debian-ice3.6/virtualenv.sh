#!/bin/bash

set -e -u -x


virtualenv /home/omero/omerowebvenv --system-site-packages
/home/omero/omerowebvenv/bin/pip install --upgrade omego
