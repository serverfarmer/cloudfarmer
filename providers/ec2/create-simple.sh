#!/bin/sh

if [ "$1" = "" ]; then
	echo "usage: $0 <ssh-key-name> [instance-type] [--async]"
	exit 1
elif [ "`which aws 2>/dev/null`" = "" ]; then
	echo "error: AWS command line client not found"
	exit 1
fi

key=$1
type=$2

path=/opt/cloud/providers/ec2
$path/create-ssh-key.sh $key >/dev/null

instance=`$path/create-instance.sh $key $type |awk "{ print \\$6 }"`

if [ "$3" = "--async" ]; then
	exit 0
fi

for S in 8 7 7 7 7 7 6 6 6 6 5 5 5 5 5 4 4 4 4 4 8; do
	sleep $S
	host=`$path/list-instances.php |grep running |grep $instance |awk "{ print \\$1 }"`
	if [ "$host" != "" ]; then
		echo $host
		exit 0
	fi
done
