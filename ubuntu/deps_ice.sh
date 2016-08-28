#!/bin/bash

set -e -u -x

ICEVER=${ICEVER:-3.6}

case "$ICEVER" in

    3.6)
        #start-supported
        apt-get -y install db5.3-util
        apt-get -y install libssl-dev libbz2-dev libmcpp-dev libdb++-dev libdb-dev
        #end-supported

  ;;
  *)
      echo "No Ice version specified skipping"
  ;;
esac
