#!/bin/bash

set -e -u -x

ICEVER=${ICEVER:-3.6}

case "$ICEVER" in

    3.6)
        #start-supported
        yum -y install gcc gcc-c++ \
        libdb-utils \
        openssl-devel bzip2-devel expat-devel
        #end-supported

  ;;
  *)
      echo "No Ice version specified skipping"
  ;;
esac
