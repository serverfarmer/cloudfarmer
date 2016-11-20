<?php

function azure_request($request)
{
	$json = shell_exec("azure $request --json");
	$data = json_decode($json, true);

	if (is_null($data))
		die("error: $json\n");

	return $data;
}

function azure_decode_instance($instance)
{
	$states = array(
		"VM running" => "running",
	);

	if (empty($instance["powerState"]))
		$state = "pending";
	else
		$state = str_replace(array_keys($states), array_values($states), $instance["powerState"]);

	$zone = $instance["location"];
	$type = $instance["hardwareProfile"]["vmSize"];
	$name = $instance["name"];
	$id = $instance["vmId"];
	$sku = $instance["storageProfile"]["imageReference"]["sku"];
	$ip = @$instance["networkProfile"]["networkInterfaces"][0]["expanded"]["ipConfigurations"][0]["publicIPAddress"]["expanded"]["ipAddress"];
	$fqdn = @$instance["networkProfile"]["networkInterfaces"][0]["expanded"]["ipConfigurations"][0]["publicIPAddress"]["expanded"]["dnsSettings"]["fqdn"];

	if (!empty($fqdn))
		$host = $fqdn;
	else if (!empty($ip))
		$host = $ip;
	else
		$host = "-";

	echo "$host $state $name $zone $type $id $sku\n";
}
