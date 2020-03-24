#!/bin/sh

if [ "$4" = "" ]; then
	echo "usage: $0 <vendor> <hostname> <ssh-key-name> <provisioning-profile>"
	exit 1
elif [ ! -d /opt/polynimbus/drivers/$1 ]; then
	echo "error: invalid cloud vendor \"$1\" specified"
	exit 1
fi

if [ -f $3 ]; then
	key=$3
else
	key=`/opt/polynimbus/drivers/$1/get-key-path.sh $3`
fi

/opt/farm/mgr/farm-provisioning/provision.sh $2 $key $4
