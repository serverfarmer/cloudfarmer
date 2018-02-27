#!/bin/sh

if [ "$2" = "" ]; then
	echo "usage: $0 <cloud-account> <ssh-key-name> [instance-type]"
	exit 1
fi

account=$1
key=$2
random=`date +%s |md5sum |head -c 4`

. /etc/local/.cloud/rackspace/$account.sh

if [ "$3" != "" ]; then
	type=$3
else
	type=$RACKSPACE_DEFAULT_INSTANCE_TYPE
fi

rack servers instance create \
	--name $key-$random \
	--flavor-id $type \
	--keypair $key \
	--image-name "$RACKSPACE_IMAGE_NAME" \
	--profile $account
