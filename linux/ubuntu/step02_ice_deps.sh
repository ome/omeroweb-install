#!/bin/bash

ICEVER=${ICEVER:-3.6}

# Ice installation
if [ "$ICEVER" = "3.6" ]; then
    #start-supported
    apt-get -y install db5.3-util
    apt-get -y install libssl-dev libbz2-dev libmcpp-dev libdb++-dev libdb-dev
    #end-supported
fi
