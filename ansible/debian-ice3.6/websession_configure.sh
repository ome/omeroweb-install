#!/bin/bash

set -e -u -x


set +u
source /home/omero/omerowebvenv/bin/activate
set -u

pip install --upgrade -r /home/omero/OMERO.py/share/web/requirements-redis.txt

/home/omero/OMERO.py/bin/omero config set omero.web.session_engine 'django.contrib.sessions.backends.cache'
/home/omero/OMERO.py/bin/omero config set omero.web.caches '{"default": {"BACKEND": "django_redis.cache.RedisCache","LOCATION": "redis://127.0.0.1:6379/0"}}'
