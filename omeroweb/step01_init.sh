#!/bin/bash

# create user
if [ -z "$(getent passwd omero)" ]; then
	#start-create-user
    useradd -m omero
    #end-create-user
fi

chmod a+X ~omero
