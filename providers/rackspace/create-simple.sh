#!/bin/sh

if [ "$1" = "" ]; then
	echo "usage: $0 <ssh-key-name> [instance-type] [--async]"
	exit 1
elif [ "`which rack 2>/dev/null`" = "" ]; then
	echo "error: Rackspace command line client not found"
	exit 1
fi

key=$1
type=$2

path=/opt/cloud/providers/rackspace
$path/create-ssh-key.sh $key >/dev/null

instance=`$path/create-instance.sh $key $type |grep ^ID |awk "{ print \\$2 }"`

if [ "$3" = "--async" ]; then
	exit 0
fi

for S in 8 7 7 7 7 7 6 6 6 6 5 5 5 5 5 4 4 4 4 4 8; do
	sleep $S
	host=`$path/list-instances.sh |grep ACTIVE |grep $instance |awk "{ print \\$4 }"`
	if [ "$host" != "" ]; then
		echo $host
		exit 0
	fi
done
