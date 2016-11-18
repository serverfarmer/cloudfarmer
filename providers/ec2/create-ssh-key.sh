#!/bin/sh
. /opt/cloud/credentials/ec2.sh

if [ "$1" = "" ]; then
	echo "usage: $0 <ssh-key-name>"
	exit 1
fi

name=$1
key=/etc/local/.ssh/id_ec2_$name

if [ -f $key ]; then
	echo "error: ssh key $key already exists"
	exit 1
fi

ssh-keygen -q -t rsa -f $key -b 4096 -N ""

public="`cat $key.pub`"
aws ec2 import-key-pair --profile $EC2_PROFILE_NAME --key-name $name --public-key-material "$public"
