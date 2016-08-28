#!/bin/bash

set -e -u -x

OMERO_USER=${OMERO_USER:-}


case "$OMERO_USER" in
  *[!\ ]*)

      # create user
      if [ -z "$(getent passwd ${OMERO_USER})" ]; then
          #start-create-user
          useradd -m "${OMERO_USER}"
          #end-create-user
      fi

      chmod a+X $(eval echo ~"${OMERO_USER}")

  ;;
  *)
      echo "No user specified skipping"
  ;;
esac
