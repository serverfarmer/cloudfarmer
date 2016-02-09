#!/bin/sh

if [ "$2" = "" ]; then
	echo "usage: $0 <awscli-profile-name> <key-name>"
	exit 1
fi

profile=$1
name=$2
key=/etc/local/.ssh/id_amazon_$name

ssh-keygen -q -t rsa -f $key -b 4096 -N ""

public="`cat $key.pub`"
out="`aws --profile $profile ec2 import-key-pair --key-name $name --public-key-material \"$public\"`"
suc="`echo \"$out\" |grep KeyFingerprint`"

if [ "$suc" = "" ]; then
	echo "error"
	exit 1
fi
