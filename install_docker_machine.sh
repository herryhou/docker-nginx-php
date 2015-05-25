#!/bin/bash
# install Docker Machine
# @see https://docs.docker.com/machine/
curl -o docker-machine -L https://github.com/docker/machine/releases/download/$MACHINE_VERSION/docker-machine_linux-amd64
chmod a+x docker-machine
sudo mv docker-machine /usr/local/bin
