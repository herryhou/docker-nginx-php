#!/bin/bash

# Convert environment variables in the conf to fixed entries
# http://stackoverflow.com/questions/21056450/how-to-inject-environment-variables-in-varnish-configuration
for name in BACKEND_PORT_80_TCP_ADDR
do
    eval value=\$$name
    sed -i "s|\${${name}}|${value}|g" /etc/varnish/default.vcl
done

# Start varnish and log
varnishd -F -f /etc/varnish/default.vcl -a :80 -T localhost:6082 -s malloc,256M -a 0.0.0.0:80 -p default_ttl=3600 -p default_grace=3600
	# -F : Run in the foreground.
	# -s [name=]type[,options]
	#           storage backend
	# -a address[:port][,address[:port][...]
	#           Listen address and port
	# -b host[:port]
	#           host and port of backend server. default port is 8080.
	# -T address[:port]
	#			address and port of the management interface

varnishlog