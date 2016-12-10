#!/bin/sh

if [ "$1" = "" ]; then
	echo "usage: $0 <provider>"
	exit 1
elif [ ! -f /opt/cloud/providers/$1/install.sh ]; then
	echo "error: invalid cloud provider specified"
	exit 1
fi

/opt/cloud/providers/$1/install.sh
