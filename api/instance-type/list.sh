#!/bin/sh

if [ "$2" = "" ]; then
	echo "usage: $0 <provider> <cloud-account>"
	exit 1
elif [ ! -d /opt/cloud/providers/$1 ]; then
	echo "error: invalid cloud provider \"$1\" specified"
	exit 1
fi

provider=$1
shift

if [ "$provider" = "e24" ]; then
	echo "m1.small"
else
	/opt/farm/ext/cloud-client-$provider/utils/list-instance-types.sh $@
fi
