#!/usr/bin/php
<?php
require_once "/opt/cloud/providers/ec2/include.php";

$data = aws_request(aws_profile(), "ec2 describe-security-groups");

foreach ($data["SecurityGroups"] as $group) {
	$name = $group["GroupName"];
	$vpcid = $group["VpcId"];
	$id = $group["GroupId"];
	echo "$vpcid $id $name\n";
}
