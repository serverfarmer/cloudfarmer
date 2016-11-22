#!/usr/bin/php
<?php

require_once "/opt/cloud/providers/e24cloud/include.php";


if ($argc < 2)
	die("usage: $argv[0] <ssh-key-name> [instance-type]\n");

$name = $argv[1];

if ($argc > 2)
	$type = $argv[2];
else
	$type = $E24CLOUD_DEFAULT_INSTANCE_TYPE;


$e24 = e24client();
$response = $e24->run_instances($E24CLOUD_AMI_ID, 1, 1, array(
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

echo "$host $state $name $E24CLOUD_REGION $type $id $image\n";


$cache = "/root/.e24-$id.dump";
$data = array(
	"ssh" => $name,
	"region" => $E24CLOUD_REGION,
	"response" => $response->body->instancesSet,
);

$json = json_encode($data, JSON_PRETTY_PRINT);
file_put_contents($cache, $json);
