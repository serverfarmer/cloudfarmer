#!/bin/bash

if [ "$2" = "" ]; then
	echo "usage: $0 <hostname> <temporary-key>"
	exit 1
elif [ ! -f $2 ]; then
	echo "error: key not found"
	exit 1
elif [ "`getent hosts $1`" = "" ]; then
	echo "error: host $1 not found"
	exit 1
fi

target=$1
tmpkey=$2

if [[ $target == *"amazonaws.com" ]]; then
	/opt/cloud/ec2/upload.sh $target $tmpkey
else
	echo "error: unknown cloud provider"
fi
