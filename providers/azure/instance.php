#!/usr/bin/php
<?php
require_once "/opt/cloud/providers/azure/include.php";

$json = "";
$fp = fopen("php://stdin", "r");

while ($line = fgets($fp))
	$json .= $line;

fclose($fp);
$data = json_decode($json, true);

if (is_null($data))
	die("error: $json\n");

azure_decode_instance($data);
