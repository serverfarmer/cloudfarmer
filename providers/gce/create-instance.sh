#!/bin/sh
. /etc/local/.cloud/gce/default.sh

if [ "$1" = "" ]; then
	echo "usage: $0 <ssh-key-name> [instance-type]"
	exit 1
fi

key=$1
random=`date +%s |md5sum |head -c 4`
name=$key-$random

if [ "$2" != "" ]; then
	type=$2
else
	type=$GCE_DEFAULT_INSTANCE_TYPE
fi

instance="$(gcloud compute instances create $name \
	--image-family $GCE_FAMILY \
	--image-project $GCE_PROJECT \
	--zone $GCE_REGION \
	--machine-type $type \
	--format json 2>/dev/null \
	|/opt/cloud/providers/gce/instance.php)"

selfLink=`echo "$instance" |cut -f6 -d" "`

gcloud compute instances add-metadata $selfLink \
	--metadata-from-file ssh-keys=/etc/local/.ssh/id_gce_$key.meta 2>/dev/null

echo $instance
