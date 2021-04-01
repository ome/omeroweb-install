#!/bin/bash
os=("centos7" "centos8" "debian9" "debian10" "ubuntu2004" "ubuntu1804")
DIR="walkthrough"
for i in "${os[@]}"
  do
    ansible-playbook ../ansible/omeroweb-install-doc.yml -i ../ansible/hosts/$i-ice3.6 --extra-vars '{"clean": True, "web_session": True}'
done

if [ -d $DIR ]; then
  rm -rf $DIR
fi
mkdir $DIR
mv ../ansible/doc/*.rst $DIR

CONDA_BASE=$(conda info --base)
CONDA_ENV=$CONDA_BASE/envs/docs-build
export OMERODIR=$CONDA_ENV
omero config set omero.web.application_server wsgi-tcp
omero web config nginx | sed "s|$CONDA_ENV|/opt/omero/web/omero-web|g" > docs/nginx-omero.conf
omero web config nginx-location | sed "s|$CONDA_ENV|/opt/omero/web/omero-web|g" | grep -v '^#' > docs/nginx-location.conf
omero web config nginx-location | sed "s|/opt/omero/web|/home/omero|g" | grep '^##' | cut -c3-> docs/nginx-location-manual-wrapper.conf


