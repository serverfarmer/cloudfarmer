#!/usr/bin/php
<?php

require_once "/opt/cloud/providers/e24/include.php";

if ($argc < 3)
	die("usage: $argv[0] <cloud-account> <ssh-key-name> [instance-type]\n");

$account = $argv[1];
$name = $argv[2];

if ($argc > 3)
	$type = $argv[3];
else
	$type = read_variable($account, "E24CLOUD_DEFAULT_INSTANCE_TYPE");


$e24 = e24client($account);
$ami_id = read_variable($account, "E24CLOUD_AMI_ID");
$response = $e24->run_instances($ami_id, 1, 1, array(
	"KeyName" => $name,
	"InstanceType" => $type,
));


if (empty($response->body->instancesSet))
	die("error: cannot create instance\n");

$id    = (string)$response->body->instancesSet->item->instanceId;
$image = (string)$response->body->instancesSet->item->imageId;
$state = (string)$response->body->instancesSet->item->instanceState->name;
$ip    = (string)$response->body->instancesSet->item->networkInterfaceSet->item->privateIpAddressesSet->item->association->publicIp;

if (empty($ip))
	$host = "-";
else if (strpos($ip, "178.216.") === false)
	$host = $ip;
else
	$host = "ip-" . str_replace(".", "-", $ip) . ".e24cloud.com";

$region = read_variable($account, "E24CLOUD_REGION");
echo "$host $state $name $region $type $id $image\n";


$cache = "/var/log/provisioning/.e24-$account-$id.dump";
$data = array(
	"ssh" => $name,
	"region" => $region,
	"response" => $response->body->instancesSet,
);

$json = json_encode($data, JSON_PRETTY_PRINT);
file_put_contents($cache, $json);
