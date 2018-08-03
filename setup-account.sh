#!/bin/sh

if [ "$2" = "" ]; then
	echo "usage: $0 <provider> <cloud-account>"
	exit 1
elif [ ! -d /opt/cloud/providers/$1 ]; then
	echo "error: invalid cloud provider specified"
	exit 1
fi

if [ -x /opt/farm/ext/cloud-client-$1/utils/setup-account.sh ]; then
	/opt/farm/ext/cloud-client-$1/utils/setup-account.sh $2
else
	/opt/cloud/providers/$1/setup-account.sh $2
fi
