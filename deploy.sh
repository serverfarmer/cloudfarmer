#!/bin/bash

if [ "$2" = "" ]; then
	echo "usage: $0 <hostname> <temporary-key>"
	exit 1
elif [ ! -f $2 ]; then
	echo "error: key not found"
	exit 1
elif ! [[ $1 =~ ^[a-z0-9.-]+[.][a-z0-9]+$ ]]; then
	echo "error: parameter $1 not conforming hostname format"
	exit 1
elif [ "`getent hosts $1`" = "" ]; then
	echo "error: host $1 not found"
	exit 1
elif [ "`cat /etc/local/.config/*.hosts |grep \"^$1$\"`" != "" ]; then
	echo "error: host $1 already added"
	exit 1
fi

target=$1
tmpkey=$2

if [[ $target == *"amazonaws.com" ]]; then
	/opt/cloud/providers/ec2/upload.sh $target $tmpkey
else
	echo "error: unknown cloud provider"
fi
