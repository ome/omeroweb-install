#!/bin/bash

set -e -u -x

yum -y install unzip wget

yum -y install \
    python-pip \
    python-virtualenv \
    libjpeg-devel
