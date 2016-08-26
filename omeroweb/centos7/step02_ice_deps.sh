#!/bin/bash

ICEVER=${ICEVER:-3.6}

# Ice installation
if [ "$ICEVER" = "3.6" ]; then
	#start-supported
	yum -y install gcc gcc-c++ \
	libdb-utils \
	openssl-devel bzip2-devel expat-devel
	#end-supported
fi