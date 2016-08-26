#!/bin/bash


set +u
source /home/omero/omerowebvenv/bin/activate
set -u

# Register the app
/home/omero/OMERO.py/bin/omero config set omero.web.session_engine 'django.contrib.sessions.backends.cache'
/home/omero/OMERO.py/bin/omero config set omero.web.caches '{"default": {"BACKEND": "redis_cache.RedisCache","LOCATION": "127.0.0.1:6379"}}'
