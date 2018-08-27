#!/bin/sh

if [ "$3" = "" ]; then
	echo "usage: $0 <provider> <cloud-account> <instance-name>"
	exit 1
elif [ ! -d /opt/cloud/providers/$1 ]; then
	echo "error: invalid cloud provider \"$1\" specified"
	exit 1
fi

/opt/farm/ext/cloud-client-$1/utils/delete-instance.sh $2 $3
