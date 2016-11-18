#!/bin/sh
. /opt/cloud/credentials/ec2.sh

if [ "$1" = "" ]; then
	echo "usage: $0 <ssh-key-name> [instance-type]"
	exit 1
fi

key=$1

if [ "$2" != "" ]; then
	type=$2
else
	type=$EC2_DEFAULT_INSTANCE_TYPE
fi

aws ec2 run-instances \
	--profile $EC2_PROFILE_NAME \
	--instance-type $type \
	--image-id $EC2_AMI_ID \
	--key-name $key \
	--security-group-ids $EC2_VPC_SECURITY_GROUP \
	--enable-api-termination \
	--associate-public-ip-address \
	--count 1 \
	|/opt/cloud/providers/ec2/reservation.php
