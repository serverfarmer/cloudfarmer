#!/bin/sh

if [ "$2" = "" ]; then
	echo "usage: $0 <cloud-account> <ssh-key-name> [instance-type] [--async]"
	exit 1
fi

account=$1
key=$2
type=$3

/opt/farm/ext/cloud-client-e24/utils/create-ssh-key.php $account $key >/dev/null

if [ ! -f /etc/local/.ssh/id_e24_$key ]; then
	echo "error: cannot create ssh key $key"
	exit 1
fi

instance=`/opt/farm/ext/cloud-client-e24/utils/create-instance.php $account $key $type |awk '{ print $6 }'`

if [ "$4" = "--async" ]; then
	exit 0
fi

for S in 6 5 5 5 5 5 4 4 4 4 3 3 3 3 3 2 2 2 2 2 8; do
	sleep $S
	host=`/opt/farm/ext/cloud-client-e24/utils/list-instances.php $account |grep running |grep $instance |awk '{ print $1 }'`
	if [ "$host" != "" ]; then
		echo $host
		exit 0
	fi
done
