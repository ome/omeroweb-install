OMERO.web installation scripts
==============================

Example OMERO.web installation scripts for [Linux](linux) and [Mac OS X](homebrew).
These scripts are provided to help new users with installing OMERO.web for the first time on a clean system, and can be used as the basis for more advanced configurations.

Read the [OMERO System Administrator Documentation](https://www.openmicroscopy.org/site/support/omero5.3-staging/sysadmins/index.html), especially the sections on requirements and installation, before using these scripts.

The Linux and OS X scripts should automatically download all required files.


Testing in DOCKER
==================

    OS = [centos7, ubuntu]

    OS=$OS OMEROVER=OMEROVER omeroweb/linux/test/docker-build.sh

    omeroweb/linux/test/test_services.sh 