#!/bin/sh

if [ "$2" = "" ]; then
	echo "usage: $0 <provider> <cloud-account>"
	exit 1
elif [ ! -d /opt/cloud/providers/$1 ]; then
	echo "error: invalid cloud provider \"$1\" specified"
	exit 1
fi

/opt/farm/ext/cloud-client-$1/utils/list-instances.sh $2
