#!/bin/bash

# This script installs requirements then builds the install scripts and docs with ansible.
# If DOCKER (which is true on github workflows) then install Docker

set -e -u -x

if [ ! -z ${TRAVIS:-} ] ; then
    if [[ ${TRAVIS_OS_NAME} == 'linux' ]]; then

        if ${DOCKER:-false} ; then
            echo "Installing Docker"
            curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
            sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
            sudo apt-get update
            sudo apt-get -y install docker-ce
        fi

    elif [[ ${TRAVIS_OS_NAME} == 'osx' ]]; then

        brew update
        brew info python
        sudo easy_install pip

    fi

    # install ansible
    sudo pip install -r requirements.txt
fi

path=`pwd`

# process env vars to pass to ansible --extra-vars accepts json dict
# script from https://gist.github.com/Jimilian/c3a2d8bb6df1b8ca64d02a10d97f510b
arr=();

arr=("os" "${OS}")
arr=(${arr[@]} "path" "${path}")
arr=(${arr[@]} "ice_version" "${ICEVER}")
if [[ ${WEBPREFIX:-} = *[!\ ]* ]]; then
    arr=(${arr[@]} "web_prefix" "${WEBPREFIX:-}")
fi
if [[ ${WEBPORT:-} = *[!\ ]* ]]; then
    arr=(${arr[@]} "web_port" "${WEBPORT:-}")
fi
if [[ ${WEBSERVER_CONF:-} = *[!\ ]* ]]; then
    arr=(${arr[@]} "web_server_conf" "${WEBSERVER_CONF:-}")
fi
if [[ ${WEBSERVER_NAME:-} = *[!\ ]* ]]; then
    arr=(${arr[@]} "web_server_name" "${WEBSERVER_NAME:-}")
fi


vars=(${arr[@]})
len=${#arr[@]}

extravars="$(printf "{"
for (( i=0; i<len; i+=2 ))
do
    printf "\"${vars[i]}\": \"${vars[i+1]}\""
    if [ $i -lt $((len-2)) ] ; then
        printf ", "
    fi
done
printf "}"
echo)"


# build scripts
ansible-playbook $path/ansible/omeroweb-install.yml -i $path/ansible/hosts/${OS}-ice${ICEVER} --extra-vars "${extravars}"

# build walkthrough sphinx page
ansible-playbook $path/ansible/omeroweb-install-doc.yml -i $path/ansible/hosts/${OS}-ice${ICEVER} --extra-vars "${extravars}"
