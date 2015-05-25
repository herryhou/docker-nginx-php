#!/bin/bash
# install weave
# @see https://github.com/zettio/weave
curl -o weave -L https://github.com/zettio/weave/releases/download/latest_release/weave
sudo chmod a+x  weave
sudo chown root weave
sudo chgrp root weave
sudo mv weave /usr/local/bin
# preload images
sudo weave setup
