#!/bin/bash
# install cAdvisor
curl -o /usr/local/bin/cadvisor -L $CADVISOR_EXE_URL
chmod a+x /usr/local/bin/cadvisor
docker pull google/cadvisor:latest

# configure for systemd
cp /vagrant/cadvisor.service  /lib/systemd/system/
sudo systemctl enable cadvisor

