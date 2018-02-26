#!/bin/sh

if [ "$3" = "" ]; then
	echo "usage: $0 <provider> <cloud-account> <ssh-key-name> [instance-type] [--async]"
	exit 1
elif [ ! -d /opt/cloud/providers/$1 ]; then
	echo "error: invalid cloud provider \"$1\" specified"
	exit 1
elif [ ! -f /etc/local/.cloud/$1/$2.sh ]; then
	echo "error: cloud account \"$2\" not configured with provider \"$1\""
	exit 1
fi

/opt/cloud/providers/$1/create-simple.sh $2 $3 $4 $5
