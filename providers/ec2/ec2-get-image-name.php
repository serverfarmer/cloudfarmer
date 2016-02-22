#!/usr/bin/php
<?php
require_once "/opt/cloud/providers/ec2/include.php";

if ($argc < 2)
	die("usage: $argv[0] <ami-id> [...]\n");

$args = escapeshellarg($argv[1]);
for ($x = 2; $x < 64; $x++)
	if (!empty($argv[$x]))
		$args .= " ".escapeshellarg($argv[$x]);

$data = aws_request(aws_profile(), "ec2 describe-images --image-ids $args");

foreach ($data["Images"] as $image) {
	$id = $image["ImageId"];
	$full = $image["Name"];
	$name = basename($full);
	echo "$id $name\n";
}
