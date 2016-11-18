#!/bin/sh

if [ "$2" = "" ]; then
	echo "usage: $0 <provider> <ssh-key-name> [instance-type] [--async]"
	exit 1
elif [ ! -f /opt/cloud/providers/$1/create-simple.sh ]; then
	echo "error: invalid cloud provider specified"
	exit 1
fi

/opt/cloud/providers/$1/create-simple.sh $2 $3 $4
