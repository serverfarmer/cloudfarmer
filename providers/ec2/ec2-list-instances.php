#!/usr/bin/php
<?php
require_once "/opt/cloud/providers/ec2/include.php";

if ($argc < 2)
	die("usage: $argv[0] <awscli-profile-name>\n");

$data = aws_request($argv[1], "ec2 describe-instances");

foreach ($data["Reservations"] as $reservation) {
	foreach ($reservation["Instances"] as $instance) {
		$state = $instance["State"]["Name"];
		$zone = $instance["Placement"]["AvailabilityZone"];
		$type = $instance["InstanceType"];
		$id = $instance["InstanceId"];
		$vpcid = $instance["VpcId"];
		$imgid = $instance["ImageId"];
		$key = $instance["KeyName"];
		$host = empty($instance["PublicDnsName"]) ? "-" : $instance["PublicDnsName"];

		$descr = "$host $state $key $zone $type $id $imgid $vpcid";

		foreach ($instance["SecurityGroups"] as $sg)
			$descr .= " " . $sg["GroupId"];

		echo "$descr\n";
	}
}
