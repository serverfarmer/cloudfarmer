<?php
#
# e24cloud.com provides service compatible with EC2, but only with
# support for Signature V2, not V4. Is requires Amazon PHP SDK 1.x
# installed somewhere in your PHP include_path. You can download
# the latest version here:
#
#    http://pear.amazonwebservices.com/get/sdk-latest.zip
#
#
# e24cloud.com API key and secret:
#
$E24CLOUD_API_KEY = "put-your-key-here";
$E24CLOUD_API_SECRET = "put-your-secret-here";
#
############################################################################
#
# Default region to use (eu-poland-1poznan or eu-poland-1warszawa):
#
$E24CLOUD_REGION = "eu-poland-1poznan";
#
# Ubuntu 14.04 LTS image id:
#
$E24CLOUD_AMI_ID = "ami-000006d8";
#
# default instance type to use, when type isn't explicitely specified
#
$E24CLOUD_DEFAULT_INSTANCE_TYPE = "m1.small";
