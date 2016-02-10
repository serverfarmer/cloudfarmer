#!/bin/sh
#
# Ubuntu 14.04 LTS image id (refreshed by Amazon every few weeks or months;
# as for now, you'll have to update it yourself; last updated 2016-02-10):
#
export EC2_AMI_ID=ami-9abea4fb
#
# VPC security group is your own subnet inside Amazon cloud and it stores
# all firewall rules (so it's tied to your AWS account):
#
export EC2_VPC_SECURITY_GROUP=sg-1234abcd
