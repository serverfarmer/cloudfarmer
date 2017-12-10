#!/bin/bash
. /opt/farm/scripts/functions.net

if [ "$2" = "" ]; then
	echo "usage: $0 <hostname> <ssh-key-path>"
	exit 1
elif [ "`resolve_host $1`" = "" ]; then
	echo "error: parameter $1 not conforming hostname format, or given hostname is invalid"
	exit 1
elif [ ! -f $2 ]; then
	echo "error: key not found"
	exit 1
elif [ "`cat /etc/local/.farm/*.hosts |grep \"^$1$\"`" != "" ]; then
	echo "error: host $1 already added"
	exit 1
fi


target=$1
tmpkey=$2

if [[ $target == *"amazonaws.com" ]]; then
	/opt/cloud/providers/ec2/upload.sh $target $tmpkey
elif [[ $target == *"bc.googleusercontent.com" ]]; then
	/opt/cloud/providers/gce/upload.sh $target $tmpkey
elif [[ $target == *"cloudapp.azure.com" ]]; then
	/opt/cloud/providers/azure/upload.sh $target $tmpkey
elif [[ $target == *"e24cloud.com" ]]; then
	/opt/cloud/providers/e24cloud/upload.sh $target $tmpkey
else
	/opt/cloud/providers/generic/upload.sh $target $tmpkey
fi


if [ -x /opt/farm/ext/farm-manager/add-dedicated-key.sh ]; then
	/opt/farm/ext/farm-manager/add-dedicated-key.sh $target root
	/opt/farm/ext/farm-manager/add-dedicated-key.sh $target backup

	if [ -x /opt/farm/ext/backup-collector/add-backup-host.sh ]; then
		/opt/farm/ext/backup-collector/add-backup-host.sh $target
	fi

	echo $target >>/etc/local/.farm/cloud.hosts
fi
