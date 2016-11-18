#!/bin/sh
. /opt/cloud/credentials/rackspace.sh

if [ "$1" = "" ]; then
	echo "usage: $0 <ssh-key-name> [instance-type]"
	exit 1
fi

key=$1
random=`date +%s |md5sum |head -c 4`

if [ "$2" != "" ]; then
	type=$2
else
	type=$RACKSPACE_DEFAULT_INSTANCE_TYPE
fi

rack servers instance create \
	--name $key-$random \
	--flavor-id $type \
	--keypair $key \
	--image-name "$RACKSPACE_IMAGE_NAME" \
	--profile $RACKSPACE_PROFILE_NAME
