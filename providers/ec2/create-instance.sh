#!/bin/sh

if [ "$2" = "" ]; then
	echo "usage: $0 <cloud-account> <ssh-key-name> [instance-type]"
	exit 1
fi

account=$1
key=$2

. /etc/local/.cloud/$account/ec2.sh

if [ "$3" != "" ]; then
	type=$3
else
	type=$EC2_DEFAULT_INSTANCE_TYPE
fi

aws ec2 run-instances \
	--profile $account \
	--instance-type $type \
	--image-id $EC2_AMI_ID \
	--key-name $key \
	--security-group-ids $EC2_VPC_SECURITY_GROUP \
	--enable-api-termination \
	--associate-public-ip-address \
	--count 1 \
	|/opt/cloud/providers/ec2/reservation.php
