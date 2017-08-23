#!/bin/bash

set -e -u -x

apt-get update
apt-get -y install \
    python-pip


apt-get -y install \
    python-pillow \
    python-numpy

