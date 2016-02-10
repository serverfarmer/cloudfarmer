#!/bin/sh
. /opt/cloud/credentials/ec2.sh

if [ "$2" = "" ]; then
	echo "usage: $0 <awscli-profile-name> <ssh-key-name> [instance-type]"
	exit 1
fi

profile=$1
key=$2

if [ "$3" != "" ]; then
	type=$3
else
	type="t2.micro"
fi

aws ec2 run-instances \
	--profile $profile \
	--instance-type $type \
	--image-id $EC2_AMI_ID \
	--key-name $key \
	--security-group-ids $EC2_VPC_SECURITY_GROUP \
	--enable-api-termination \
	--associate-public-ip-address \
	--count 1 \
	|/opt/cloud/providers/ec2/ec2-reservation.php
