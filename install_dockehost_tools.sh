#!/bin/bash
# install Docker-Host-Tools
# @see https://github.com/William-Yeh/docker-host-tools
DOCKER_HOST_TOOLS=( docker-rm-stopped  docker-rmi-repo  docker-inspect-attr )
for item in "${DOCKER_HOST_TOOLS[@]}"; do
  curl -o /usr/local/bin/$item  -sSL https://raw.githubusercontent.com/William-Yeh/docker-host-tools/master/$item
  chmod a+x /usr/local/bin/$item
done