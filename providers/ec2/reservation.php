#!/usr/bin/php
<?php
require_once "/opt/cloud/providers/ec2/include.php";

$json = "";
$fp = fopen("php://stdin", "r");

while ($line = fgets($fp))
	$json .= $line;

fclose($fp);
$data = json_decode($json, true);

if (empty($data))
	die("error\n");

aws_decode_reservation($data);
