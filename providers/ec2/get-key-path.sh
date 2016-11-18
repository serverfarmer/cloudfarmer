#!/bin/sh
# this script either prints the ssh private key path (if it exists),
# or exits with error code - it may be used outside of EC2 part to
# just get the key path without digging into EC2 implementation details
# Tomasz Klim, Feb 2016

key=/etc/local/.ssh/id_ec2_$1

if [ -f $key ]; then
	echo $key
else
	exit 1
fi
