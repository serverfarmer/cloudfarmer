#!/bin/sh

if [ "$2" = "" ]; then
	echo "usage: $0 <cloud-account> <ssh-key-name>"
	exit 1
fi

account=$1
name=$2
key=/etc/local/.ssh/id_ec2_$name

if [ -f $name ] || [ -f $key ]; then
	echo "warning: ssh key $key already exists"
	exit 0
fi

ssh-keygen -q -t rsa -f $key -b 4096 -N ""

public="`cat $key.pub`"
aws ec2 import-key-pair --profile $account --key-name $name --public-key-material "$public"
