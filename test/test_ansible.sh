#!/bin/bash

set -e -u -x

OS=${OS:-centos7}
ICEVER=${ICEVER:-3.6}

WEBPREFIX=${WEBPREFIX:-}
WEBPORT=${WEBPORT:-80}
WEBSERVER_NAME=${WEBSERVER_NAME:-localhost}
WEBSERVER_CONF=${WEBSERVER_CONF:-nginx}

path=`dirname $0`

IMAGE=omeroweb_install_test_ansible_${OS}_ice${ICEVER}

docker stop ${IMAGE} || echo 'containers cleaned'
docker rm ${IMAGE} || echo 'containers cleaned'

# start docker container
if [[ "darwin" == "${OSTYPE//[0-9.]/}" ]]; then
    docker run -d --privileged -p 2222:22 -p 8888:80 --name ${IMAGE} ${IMAGE}
else
    docker run -d --name ${IMAGE} -v /sys/fs/cgroup:/sys/fs/cgroup:ro -v /run ${IMAGE}
fi

if [[ "darwin" == "${OSTYPE//[0-9.]/}" ]]; then
  DOCKER_IP=localhost
else
  DOCKER_IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${IMAGE})
fi

sleep 5

# check if container is running
docker inspect -f {{.State.Running}} ${IMAGE}


# run playbook
cat << EOF > ${OS}-ice${ICEVER}
[centos7-ice3.6]
${DOCKER_IP} ansible_port=2222 ansible_host=${DOCKER_IP} ansible_user=${OS} ansible_ssh_pass=${OS}
EOF

ansible-playbook $path/../ansible/omeroweb-install.yml -i ${OS}-ice${ICEVER} --extra-vars "web_prefix=${WEBPREFIX} web_server_name=${WEBSERVER_NAME} web_port=${WEBPORT} clean=True"
docker exec -it ${IMAGE} /bin/bash -c "su - ${OS} -c \"mv ~/${OS}-ice${ICEVER} ~/omeroweb-install-${OS}-ice${ICEVER} /tmp/\""
docker exec -it ${IMAGE} /bin/bash -c "su - ${OS} -c \"sudo /tmp/omeroweb-install-${OS}-ice${ICEVER}\""

docker logs ${IMAGE}

#test 
if [[ "darwin" == "${OSTYPE//[0-9.]/}" ]]; then
    curl -f -I http://${DOCKER_IP}:8888${WEBPREFIX}/webclient/login/
else
    curl -f -I http://${DOCKER_IP}:${WEBPORT}${WEBPREFIX}/webclient/login/
fi


# stop and cleanup
docker stop ${IMAGE}
docker rm ${IMAGE}

rm -f ${OS}-ice${ICEVER}
