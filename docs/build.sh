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