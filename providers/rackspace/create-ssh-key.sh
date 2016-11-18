#!/bin/sh
. /opt/cloud/credentials/rackspace.sh

if [ "$1" = "" ]; then
	echo "usage: $0 <ssh-key-name>"
	exit 1
fi

name=$1
key=/etc/local/.ssh/id_rack_$name

if [ -f $key ]; then
	echo "error: ssh key $key already exists"
	exit 1
fi

ssh-keygen -q -t rsa -f $key -b 4096 -N ""

public="`cat $key.pub`"
rack servers keypair upload --name $name --public-key "$public" --profile $RACKSPACE_PROFILE_NAME
