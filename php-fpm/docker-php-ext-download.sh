#!/bin/bash
set -e

ext="$1"
ver="$2"
download="$ext-$ver"

if [ -z "$ver"]; then
	download="$ext"
fi

mkdir -p /tmp/pear/download
cd /tmp/pear/download
pecl download $download
mkdir -p /usr/src/php/ext/$ext
tar -xvzf $ext-* -C /usr/src/php/ext/$ext --strip-components 1