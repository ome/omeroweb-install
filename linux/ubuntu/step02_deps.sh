#!/bin/bash

apt-get update
apt-get -y install \
    unzip \
    wget \
    python-{dev,pip,virtualenv}

# require to install Pillow
apt-get -y install \
    libtiff5-dev \
    libjpeg8-dev \
    zlib1g-dev 

pip install --upgrade pip
