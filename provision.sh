#!/bin/sh

if [ "$4" = "" ]; then
	echo "usage: $0 <provider> <hostname> <ssh-key-name> <provisioning-profile>"
	exit 1
elif [ ! -d /opt/cloud/providers/$1 ]; then
	echo "error: invalid cloud provider specified"
	exit 1
fi

if [ -f $3 ]; then
	key=$3
else
	key=`/opt/cloud/providers/$1/get-key-path.sh $3`
fi

/opt/farm/ext/farm-provisioning/provision.sh $2 $key $4
