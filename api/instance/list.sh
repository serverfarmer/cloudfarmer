#!/bin/sh

if [ "$2" = "" ]; then
	echo "usage: $0 <provider> <cloud-account>"
	exit 1
elif [ ! -d /opt/cloud/providers/$1 ]; then
	echo "error: invalid cloud provider \"$1\" specified"
	exit 1
fi

if [ -x /opt/farm/ext/cloud-client-$1/utils/list-instances.php ]; then
	/opt/farm/ext/cloud-client-$1/utils/list-instances.php $2
else
	/opt/farm/ext/cloud-client-$1/utils/list-instances.sh $2
fi
