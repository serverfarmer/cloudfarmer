#!/bin/sh

if [ "$1" = "" ]; then
	echo "usage: $0 <provider>"
	exit 1
elif [ ! -d /opt/cloud/providers/$1 ]; then
	echo "error: invalid cloud provider specified"
	exit 1
fi

provider=$1
shift

/opt/farm/ext/cloud-client-$provider/utils/list-accounts.sh $@
