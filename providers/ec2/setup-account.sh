#!/bin/sh
. /opt/farm/scripts/functions.dialog

if [ "$1" = "" ]; then
	echo "usage: $0 <cloud-account>"
	exit 1
elif [ -f /etc/local/.cloud/$1/ec2.sh ]; then
	echo "error: cloud account \"$1\" already configured"
	exit 1
fi

account=$1
aws configure --profile $account

if ! grep -q "\[$account\]" /root/.aws/credentials; then
	echo "error: cloud account \"$account\" left unconfigured"
	exit 1
fi

DEFAULT_INSTANCE_TYPE="`input \"enter ec2 default instance type\" t2.micro`"
VPC_ID="`input \"enter EC2 VPC security group id\" sg-1234abcd`"
AMI_ID="`input \"enter EC2 AMI id for latest Ubuntu LTS image\" ami-0d77397e`"

mkdir -p /etc/local/.cloud/$account
echo "#!/bin/sh
#
# CloudFarmer requires awscli AWS command line client, which support
# multiple configured AWS accounts. This variable links this profile
# with account configuration.
#
export EC2_PROFILE_NAME=$account
#
# VPC security group is your own subnet inside Amazon cloud and it stores
# all firewall rules (so it's tied to your AWS account):
#
export EC2_VPC_SECURITY_GROUP=$VPC_ID
#
#
############################################################################
#
# Ubuntu 14.04 LTS or 16.04 LTS image id (refreshed by Amazon every
# few weeks or months; as for now, you'll have to find and update it
# yourself using https://cloud-images.ubuntu.com/locator/ec2/ page,
# choosing hvm:ebs-ssd as instance type):
#
export EC2_AMI_ID=$AMI_ID
#
# default instance type to use, when type isn't explicitely specified
#
export EC2_DEFAULT_INSTANCE_TYPE=$DEFAULT_INSTANCE_TYPE
" >/etc/local/.cloud/$account/ec2.sh
chmod 0600 /etc/local/.cloud/$account/ec2.sh
