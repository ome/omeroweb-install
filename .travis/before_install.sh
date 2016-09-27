#!/bin/bash

set -e -u -x

if ${TRAVIS:-} ; then
    if [[ ${TRAVIS_OS_NAME} == 'linux' ]]; then

        if ${DOCKER:-false} ; then
            echo "Installing Docker"
            sudo apt-get update
            sudo DEBIAN_FRONTEND=noninteractive apt-get install -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" docker-engine
        fi

    elif [[ ${TRAVIS_OS_NAME} == 'osx' ]]; then

        brew update
        sudo easy_install pip

    fi

    # install ansible
    sudo pip install -r requirements.txt
fi

# process env vars to pass to ansible --extra-vars accepts json dict
# script from https://gist.github.com/Jimilian/c3a2d8bb6df1b8ca64d02a10d97f510b
arr=();

arr=("os" "${OS}")
arr=(${arr[@]} "ice_version" "${ICEVER}")
if [[ ${OMEROVER:-} = *[!\ ]* ]]; then
    arr=(${arr[@]} "omero_version" "${OMEROVER:-}")
fi
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
if [ "${ICEVER}" == "3.5" ]; then
    arr=(${arr[@]} "system_site_packages" "True")
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

path=`dirname $0`/..

# build scripts
ansible-playbook $path/ansible/omeroweb-install.yml -i $path/ansible/hosts/${OS}-ice${ICEVER} --extra-vars "${extravars}"

# build walkthrough sphinx page
ansible-playbook $path/ansible/omeroweb-install-doc.yml -i $path/ansible/hosts/${OS}-ice${ICEVER} --extra-vars "${extravars}"
