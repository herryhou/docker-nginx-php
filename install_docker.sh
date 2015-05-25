#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8


readonly COMPOSE_VERSION=1.2.0
readonly MACHINE_VERSION=v0.2.0

readonly DOCKERGEN_VERSION=0.3.9
readonly DOCKERGEN_TARBALL=docker-gen-linux-amd64-$DOCKERGEN_VERSION.tar.gz

readonly DOCKERIZE_VERSION=v0.0.2
readonly DOCKERIZE_TARBALL=dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

readonly CADVISOR_VERSION=0.12.0
readonly CADVISOR_EXE_URL=https://github.com/google/cadvisor/releases/download/$CADVISOR_VERSION/cadvisor

# update packages
sudo apt-get update
#sudo apt-get -y -q upgrade
#sudo apt-get -y -q dist-upgrade

#---------------------------------------#
# Docker-related stuff
#

# install Docker
curl -sL https://get.docker.io/ | sudo sh

# configure for systemd
cp /vagrant/docker.service  /lib/systemd/system/
cp /vagrant/docker.socket   /lib/systemd/system/

# enabled when booting
sudo systemctl enable docker
sudo systemctl start  docker


# enable memory and swap accounting
sed -i -e \
  's/^GRUB_CMDLINE_LINUX=.+/GRUB_CMDLINE_LINUX="cgroup_enable=memory swapaccount=1"/' \
  /etc/default/grub
sudo update-grub

# enable UFW forwarding
sed -i -e \
  's/^DEFAULT_FORWARD_POLICY=.+/DEFAULT_FORWARD_POLICY="ACCEPT"/' \
  /etc/default/ufw
sudo sysctl -w net.ipv4.ip_forward=1
cat << EOF_UFW >> /etc/sysctl.conf

# enable UFW forwarding for Docker
net.ipv4.ip_forward=1

EOF_UFW
#sudo ufw reload

# install Docker Compose (was: Fig)
# @see http://docs.docker.com/compose/install/
curl -o docker-compose -L https://github.com/docker/compose/releases/download/$COMPOSE_VERSION/docker-compose-`uname -s`-`uname -m`
chmod a+x docker-compose
sudo mv docker-compose /usr/local/bin


# install Docker Compose (was: Fig)
# @see http://docs.docker.com/compose/install/
curl -o docker-compose -L https://github.com/docker/compose/releases/download/$COMPOSE_VERSION/docker-compose-`uname -s`-`uname -m`
chmod a+x docker-compose
sudo mv docker-compose /usr/local/bin
