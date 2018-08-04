#!/bin/sh

if [ "$2" = "" ]; then
	echo "usage: $0 <cloud-account> <ssh-key-name> [instance-type]"
	exit 1
fi

account=$1
key=$2

. /etc/local/.cloud/ec2/$account.sh

if [ "$3" != "" ]; then
	type=$3
else
	type=$EC2_DEFAULT_INSTANCE_TYPE
fi

region=`/opt/farm/ext/cloud-client-ec2/utils/get-configured-region.sh $account`
amiid=`/opt/farm/ext/cloud-client-ec2/utils/get-ami-id.sh $region 18.04`

aws ec2 run-instances \
	--profile $account \
	--instance-type $type \
	--image-id $amiid \
	--key-name $key \
	--security-groups default \
	--enable-api-termination \
	--associate-public-ip-address \
	--count 1 \
	|/opt/farm/ext/cloud-client-ec2/internal/parse-reservation.php
