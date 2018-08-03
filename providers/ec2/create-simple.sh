#!/bin/sh

if [ "$2" = "" ]; then
	echo "usage: $0 <cloud-account> <ssh-key-name> [instance-type] [--async]"
	exit 1
fi

account=$1
key=$2
type=$3

/opt/farm/ext/cloud-client-ec2/utils/create-ssh-key.sh $account $key >/dev/null

instance=`/opt/cloud/providers/ec2/create-instance.sh $account $key $type |awk "{ print \\$6 }"`

if [ "$4" = "--async" ]; then
	exit 0
fi

for S in 8 7 7 7 7 7 6 6 6 6 5 5 5 5 5 4 4 4 4 4 8; do
	sleep $S
	host=`/opt/farm/ext/cloud-client-ec2/utils/list-instances.php $account |grep running |grep $instance |awk "{ print \\$1 }"`
	if [ "$host" != "" ]; then
		echo $host
		exit 0
	fi
done
