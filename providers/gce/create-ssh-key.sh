#!/bin/sh

if [ "$1" = "" ]; then
	echo "usage: $0 <ssh-key-name>"
	exit 1
fi

name=$1
key=/etc/local/.ssh/id_gce_$name

if [ -f $key ]; then
	echo "error: ssh key $key already exists"
	exit 1
fi

ssh-keygen -q -t rsa -f $key -b 4096 -N "" -C ubuntu@`hostname`

echo -n ubuntu: >$key.meta
cat $key.pub >>$key.meta
