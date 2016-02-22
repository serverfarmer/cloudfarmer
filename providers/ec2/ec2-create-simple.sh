#!/bin/sh

if [ "$1" = "" ]; then
	echo "usage: $0 <ssh-key-name> [instance-type]"
	exit 1
fi

key=$1
type=$2

path=/opt/cloud/providers/ec2
out=`$path/ec2-create-ssh-key.sh $key`

if [ "$out" != "" ]; then
	echo "$out"
	exit 1
fi

instance=`$path/ec2-create-instance.sh $key $type |awk "{ print \\$6 }"`

for S in 6 4 4 4 4 4 4 3 3 3 3 3 3 3 3 8; do
	sleep $S
	host=`$path/ec2-list-instances.php |grep running |grep $instance |awk "{ print \\$1 }"`
	if [ "$host" != "" ]; then
		echo $host
		exit 0
	fi
done
