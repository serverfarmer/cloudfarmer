<?php

function aws_profile()
{
	$out = shell_exec("/opt/cloud/providers/ec2/ec2-get-profile.sh");
	return trim($out);
}

function aws_client($profile = "default")
{
	$_profile = escapeshellarg($profile);
	return "/usr/local/bin/aws --profile $_profile";
}

function aws_request($profile, $request)
{
	$aws = aws_client($profile);
	$json = shell_exec("$aws $request");
	$data = json_decode($json, true);

	if (empty($data))
		die("error\n");

	return $data;
}

function aws_decode_reservation($reservation)
{
	foreach ($reservation["Instances"] as $instance) {
		$state = $instance["State"]["Name"];
		$zone = $instance["Placement"]["AvailabilityZone"];
		$type = $instance["InstanceType"];
		$id = $instance["InstanceId"];
		$imgid = $instance["ImageId"];
		$key = $instance["KeyName"];
		$host = empty($instance["PublicDnsName"]) ? "-" : $instance["PublicDnsName"];
		$vpcid = empty($instance["VpcId"]) ? "-" : $instance["VpcId"];

		$descr = "$host $state $key $zone $type $id $imgid $vpcid";

		foreach ($instance["SecurityGroups"] as $sg)
			$descr .= " " . $sg["GroupId"];

		echo "$descr\n";
	}
}
