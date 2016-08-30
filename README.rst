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


Prerequisites
-------------

::

    pip install ansible


Building
--------

::

    ./build --os=(centos7|ubuntu|osx)


Additional arguments

| ARG                | default | optional                | example                  |
|--------------------|---------|-------------------------|--------------------------|
| ice-version        | 3.6     | 3.5|3.6                 |                          |
| omero-version      | latest  |                         | OMERO-DEV-breaking-build |
| web-port           | 80      |                         | 8080                     |
| web-prefix         |         |                         | /omero                   |
| web-server-name    |         |                         | omero.example.com        |
| web-server-config  | nginx   | nginx|nginx-development |                          |
| web-session        | False   | True|False              |                          |


Running
-------

on Mac OS X::

    ./omeroweb-install-osx
    ./osx/run

on Ubuntu::

    ./omeroweb-install-ubuntu
    ./ubuntu/run

on Centos 7::

    ./omeroweb-install-centos7

optional:

| VAR            | default | optional                | example                  |
|----------------|---------|-------------------------|--------------------------|
| ICEVER         | 3.6     | 3.5|3.6                 |                          |
| OMEROVER       | latest  |                         | OMERO-DEV-breaking-build |
| WEBPORT        | 80      |                         | 8080                     |
| WEBPREFIX      |         |                         | /omero                   |
| WEBSERVER_NAME |         |                         | omero.example.com        |
| WEBSERVER_CONF | nginx   | nginx|nginx-development |                          |
| WEBSESSION     | False   | True|False              |                          |

Testing in DOCKER
-----------------


for OS [centos7, ubuntu]::

    ./test/docker-build.sh
    ./test/test_services.sh 

Unfortunately no docker container for Mac OS X

Copyright
---------

2016, The Open Microscopy Environment
