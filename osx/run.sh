
#!/usr/bin/env bash
# Start up server, perform some simple test, shutdown again.

set -e -u -x

set +u
source ~/omerowebvenv/bin/activate
set -u

# Start OMERO.web
~/OMERO.py/bin/omero web start

# Start webserver
sudo nginx -c ~/omeroweb-nginx.conf
