#!/bin/sh

if [ "$1" = "" ]; then
	echo "usage: $0 <ssh-key-name> [instance-type] [--async]"
	exit 1
elif [ "`which gcloud 2>/dev/null`" = "" ]; then
	echo "error: gcloud command line client not found"
	exit 1
fi

key=$1
type=$2

path=/opt/cloud/providers/gce
$path/create-ssh-key.sh $key >/dev/null

host=`$path/create-instance.sh $key $type |awk "{ print \\$1 }"`

if [ "$host" = "" ]; then
	exit 1
fi

if [ "$3" = "--async" ]; then
	exit 0
fi

echo $host
