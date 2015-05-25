#!/bin/bash
# install dockerize
# @see https://github.com/jwilder/dockerize
curl -o dockerize.tar.gz -L https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/$DOCKERIZE_TARBALL
tar xzvf dockerize.tar.gz
sudo chown root dockerize
sudo chgrp root dockerize
sudo mv dockerize /usr/local/bin
rm *.tar.gz