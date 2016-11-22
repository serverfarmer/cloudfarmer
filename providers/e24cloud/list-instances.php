#!/usr/bin/php
<?php

require_once "/opt/cloud/providers/e24cloud/include.php";


$e24 = e24client();
$response = $e24->describe_instances();

foreach ($response->body->reservationSet->item as $item) {
	$instance = $item->instancesSet->item;

	$id    = (string)$instance->instanceId;
	$type  = (string)$instance->instanceType;
	$host  = (string)$instance->dnsName;
	$image = (string)$instance->imageId;
	$state = (string)$instance->instanceState->name;

	$sshkey = "-ssh";
	$region = "-region";
	$cache  = "/root/.e24-$id.dump";

	if (file_exists($cache)) {
		$json = file_get_contents($cache);
		$data = json_decode($json, true);

		if (isset($data["ssh"]) && isset($data["region"])) {
			$sshkey = $data["ssh"];
			$region = $data["region"];
		}
	}

	echo "$host $state $sshkey $region $type $id $image\n";
}
