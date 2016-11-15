#!/bin/sh
#
# CloudFarmer requires awscli AWS command line client. This variable
# should point to valid, configured AWS profile. By default, when
# you configure awscli like this:
#
#    apt-get install python-pip
#    pip install awscli
#    aws configure
#
# then your profile name is "default".
#
# By using:
#
#    aws configure --profile custom-name
#
# you can use multiple profiles, linked to multiple AWS accounts.
#
export EC2_PROFILE_NAME=default
#
# VPC security group is your own subnet inside Amazon cloud and it stores
# all firewall rules (so it's tied to your AWS account):
#
export EC2_VPC_SECURITY_GROUP=sg-1234abcd
#
#
############################################################################
#
# Ubuntu 14.04 LTS or 16.04 LTS image id (refreshed by Amazon every
# few weeks or months; as for now, you'll have to update it yourself):
#
export EC2_AMI_ID=ami-0d77397e
#
# default instance type to use, when type isn't explicitely specified
#
export EC2_DEFAULT_INSTANCE_TYPE=t2.micro
