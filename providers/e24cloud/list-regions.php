#!/usr/bin/php
<?php

require_once "/opt/cloud/providers/e24cloud/include.php";


$e24 = e24client();
$response = $e24->describe_regions();

foreach ($response->body->regionInfo->item as $item) {
	$region = (string)$item->regionName;
	$endpoint = (string)$item->regionEndpoint;
	echo "$region\t$endpoint\n";
}
