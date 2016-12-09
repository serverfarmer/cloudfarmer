<?php

function gce_request($request)
{
	$json = shell_exec("gcloud compute $request --format json");
	$data = json_decode($json, true);

	if (is_null($data))
		die("error: $json\n");

	return $data;
}

function gce_decode_instance($instance)
{
	$states = array(
		"RUNNING" => "running",
	);

	if (empty($instance["status"]))
		$state = "pending";
	else
		$state = str_replace(array_keys($states), array_values($states), $instance["status"]);

	$zone = $instance["zone"];
	$type = $instance["machineType"];
	$name = $instance["name"];
	$link = $instance["selfLink"];
	$system = basename($instance["disks"][0]["licenses"][0]);
	$ip = @$instance["networkInterfaces"][0]["accessConfigs"][0]["natIP"];

	if (empty($ip))
		$host = "-";
	else if (($rev = gethostbyaddr($ip)) !== false)
		$host = $rev;
	else
		$host = $ip;

	echo "$host $state $name $zone $type $link $system\n";
}
