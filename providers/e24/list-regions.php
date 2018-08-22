#!/usr/bin/php
<?php

require_once "/opt/cloud/providers/e24/include.php";

if ($argc < 2)
	die("usage: $argv[0] <cloud-account>\n");

$account = $argv[1];

$e24 = e24client($account);
$response = $e24->describe_regions();

foreach ($response->body->regionInfo->item as $item) {
	$region = (string)$item->regionName;
	$endpoint = (string)$item->regionEndpoint;
	echo "$region\t$endpoint\n";
}
