#!/bin/bash

#start-install
# The following is only required to install
# latest stable version of nginx
# Default will be 1.6.3 if not set
cat << EOF > /etc/yum.repos.d/nginx.repo
[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/centos/\$releasever/\$basearch/
gpgcheck=0
enabled=1
EOF

#install nginx
yum -y install nginx

#end-install
sed -i.bak -re 's/( default_server.*)/; #\1/' /etc/nginx/nginx.conf
mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.disabled
mv /home/omero/nginx.conf.tmp /etc/nginx/conf.d/omeroweb.conf

systemctl enable nginx
if [ ! "${container:-}" = docker ]; then
    systemctl start nginx
fi
