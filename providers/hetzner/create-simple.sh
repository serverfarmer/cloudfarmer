#!/bin/sh

if [ "$2" = "" ]; then
	echo "usage: $0 <cloud-account> <ssh-key-name> [instance-type] [--async]"
	exit 1
fi

account=$1
key=$2
type=$3

/opt/farm/ext/cloud-client-hetzner/utils/create-ssh-key.sh $account $key >/dev/null

host=`/opt/farm/ext/cloud-client-hetzner/utils/create-instance.sh $account $key $type`

if [ "$host" = "" ]; then
	exit 1
fi

if [ "$4" = "--async" ]; then
	exit 0
fi

for S in 8 7 7 7 7 7 6 6 6 6 5 5 5 5 5 4 4 4 4 4 8; do
	sleep $S
	found=`/opt/farm/ext/cloud-client-hetzner/utils/list-instances.sh $account |grep running |grep $host`
	if [ "$found" != "" ]; then
		echo $host
		exit 0
	fi
done
