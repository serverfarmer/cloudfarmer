#!/bin/sh

if [ "$2" = "" ]; then
	echo "usage: $0 <provider> <key-name>"
	exit 1
elif [ ! -d /opt/cloud/providers/$1 ]; then
	echo "error: invalid cloud provider \"$1\" specified"
	exit 1
fi

provider=$1
shift

/opt/farm/ext/cloud-client-$provider/utils/get-key-path.sh $@
