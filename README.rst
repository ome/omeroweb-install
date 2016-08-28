.. image:: https://travis-ci.org/aleksandra-tarkowska/omeroweb-install.svg?branch=master
    :target: https://travis-ci.org/aleksandra-tarkowska/omeroweb-install


OMERO.web installation scripts
==============================

Example OMERO.web installation scripts for Linux: Centos7, Ubuntu and Mac OS X.
These scripts are provided to help new users with installing OMERO.web for the
first time on a clean system, and can be used as the basis for more advanced
configurations.

Read the OMERO System Administrator Documentation https://www.openmicroscopy.org/site/support/omero5.3-staging/sysadmins/index.html,
especially the sections on requirements and installation, before using these scripts.

The Linux and OS X scripts should automatically download all required files.


Running
-------

on Mac OS X::

    export OS=osx
    ./install.sh
    ./run.sh 

on Ubuntu::

    export OMERO_USER=omero
    export OS=ubuntu

    ./install.sh
    ./run.sh 

on Centos 7::

    export OMERO_USER=omero
    export OS=centos7
    ./install.sh 

optional:

custom build::

   export OMEROVER=OMERO-DEV-breaking-build 

Testing in DOCKER
-----------------

for OS [centos7, ubuntu]::

    export OS=OS
    export OMEROVER=OMEROVER
    ./test/docker-build.sh
    ./test/test_services.sh 

Unfortunately no docker container for Mac OS X

Copyright
---------

2016, The Open Microscopy Environment
