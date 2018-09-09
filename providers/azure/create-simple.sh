#!/bin/sh

if [ "$2" = "" ]; then
	echo "usage: $0 <cloud-region> <ssh-key-name> [instance-type]"
	exit 1
fi

region=$1
key=$2
type=$3

/opt/farm/ext/cloud-client-azure/utils/create-ssh-key.sh $region $key >/dev/null
/opt/farm/ext/cloud-client-azure/utils/create-instance.sh $region $key $type
