#!/bin/bash

hstype=`/opt/farm/scripts/config/detect-hostname-type.sh $1`

if [ "$2" = "" ]; then
	echo "usage: $0 <hostname> <ssh-key-path>"
	exit 1
elif [ ! -f $2 ]; then
	echo "error: key not found"
	exit 1
elif [ "$hstype" != "hostname" ] && [ "$hstype" != "ip" ]; then
	echo "error: parameter $1 not conforming hostname format, or given hostname is invalid"
	exit 1
elif [ "`cat /etc/local/.farm/*.hosts |grep \"^$1$\"`" != "" ]; then
	echo "error: host $1 already added"
	exit 1
fi

target=$1
tmpkey=$2

if [[ $target == *"amazonaws.com" ]]; then
	/opt/cloud/providers/ec2/upload.sh $target $tmpkey
else
	/opt/cloud/providers/generic/upload.sh $target $tmpkey
fi
