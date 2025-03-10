OMERO.web installation scripts
==============================

[![Actions Status](https://github.com/ome/omeroweb-install/workflows/Build/badge.svg)](https://github.com/ome/omeroweb-install/actions)

Example of OMERO.web installation scripts for Linux: CentOS7, CentOS8, Rocky 9, Ubuntu 18.04, 20.04, Debian 9 and 10.
These scripts are provided to help new users with installing OMERO.web for the
first time on a clean system, and can be used as the basis for more advanced
configurations.

Read the OMERO System Administrator Documentation https://docs.openmicroscopy.org/latest/omero/sysadmins/index.html,
especially the sections on requirements and installation, before using these scripts.

The Linux scripts should automatically download all required files.

The scripts will only work locally due to the usage of ``{{playbook_dir}}``.
This ensures that the generated documentation will be created in the same location
regardless of the version of Ansible installed.

Prerequisites
-------------

    pip install -r requirements.txt


Building
--------

    ansible-playbook ./ansible/omeroweb-install.yml -i ./ansible/hosts/rockylinux9-ice3.6

to clean up existing scripts:

    ansible-playbook ./ansible/omeroweb-install.yml -i ./ansible/hosts/rockylinux9-ice3.6 --extra-vars "clean=True"

Scripts are autogenerated using ansible, that means they can build directly on the remote host.
Create your own copy of inventory, e.g. `ansible/hosts/rockylinux9-ice3.6`  and define a list of hosts

    cat << EOF > /path/to/hosts/rockylinux9-ice3.6
    [rockylinux9-ice3.6]
    omeroweb1.example.com ansible_port=22 ansible_host=omeroweb1.example.com ansible_user=username ansible_ssh_pass=secret
    EOF

    ansible-playbook ./ansible/omeroweb-install.yml -i /path/to/hosts/rockylinux9-ice3.6


Extra vars arguments:

| ARG                | default | optional                | example                  |
|--------------------|---------|-------------------------|--------------------------|
| web_port           | 80      |                         |                          |
| web_prefix         |         |                         | /omero                   |
| web_server_name    |         |                         | omero.example.com        |
| web_session        | False   | True|False              |                          |
| clean              | False   | True|False              |                          |

example usage:

    ansible-playbook ./ansible/omeroweb-install.yml -i ./hosts/rockylinux9-ice3.6 --extra-vars "web_prefix=/omero web_server_name=IP_GOES_HERE web_port=80"

Running
-------

Environment variables:

| VAR            | default | optional                | example                  |
|----------------|---------|-------------------------|--------------------------|
| WEBPORT        | 80      |                         |                          |
| WEBPREFIX      |         |                         | /omero                   |
| WEBSERVER_NAME |         |                         | omero.example.com        |
| WEBSESSION     | False   | True|False              |                          |


and run for example

on Rocky 9:

    ./omeroweb-install-rockylinux9-ice3.6

To run installation scripts on a remote host:

    $ # copy over installation scripts from the ansible directory
    $ scp -r ansible/omeroweb-install-rockylinux9-ice3.6 ansible/rockylinux9-ice3.6 bob@hostname:/tmp/ 
    $ ssh bob@hostname
    $ sudo su # switch to root user
    $ chmod -R a+r /tmp/rockylinux9-ice3.6  # omero-web user will need read access
    $ bash /tmp/omeroweb-install-rockylinux9-ice3.6


Testing in DOCKER
-----------------

These tests are only for CentOS, Ubuntu, and Debian deployments. Unfortunately there is no docker container for Mac OS X installation scripts

    OS=rockylinux9 ICEVER=3.6 WEBPREFIX=/omero .travis/before_install.sh
    OS=rockylinux9 ICEVER=3.6 WEBPREFIX=/omero DOCKER=true TRAVIS_OS_NAME=linux .travis/install.sh
    OS=rockylinux9 ICEVER=3.6 WEBPREFIX=/omero DOCKER=true TRAVIS_OS_NAME=linux .travis/script.sh 
 
To test remote build set `ANSIBLE=true`
Note: make sure you always set `DOCKER=true` when running local test. Otherwise it will attempt to install OMERO.web on you local machine

Note: running tests on Mac OS X requires Docker for Mac (Docker Toolbox is not supported)

Copyright
---------

2016-2024, The Open Microscopy Environment
