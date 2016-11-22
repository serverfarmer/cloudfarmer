#!/bin/sh

if [ "$1" = "" ]; then
	echo "usage: $0 <ssh-key-name> [instance-type] [--async]"
	exit 1
fi

key=$1
type=$2

path=/opt/cloud/providers/e24cloud
$path/create-ssh-key.php $key

if [ ! -f /etc/local/.ssh/id_e24_$key ]; then
	exit 1
fi

instance=`$path/create-instance.php $key $type |awk "{ print \\$6 }"`

if [ "$3" = "--async" ]; then
	exit 0
fi

for S in 6 5 5 5 5 5 4 4 4 4 3 3 3 3 3 2 2 2 2 2 8; do
	sleep $S
	host=`$path/list-instances.php |grep running |grep $instance |awk "{ print \\$1 }"`
	if [ "$host" != "" ]; then
		echo $host
		exit 0
	fi
done
