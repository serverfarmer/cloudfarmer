#!/usr/bin/php
<?php

require_once "/opt/cloud/providers/e24cloud/include.php";

if ($argc < 2)
	die("usage: $argv[0] <cloud-account>\n");

$account = $argv[1];

$e24 = e24client($account);
$response = $e24->describe_key_pairs();

foreach ($response->body->keySet->item as $item) {
	$name = (string)$item->keyName;
	echo "$name\n";
}
