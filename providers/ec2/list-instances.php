#!/usr/bin/php
<?php
require_once "/opt/cloud/providers/ec2/include.php";

if ($argc < 2)
	die("usage: $argv[0] <cloud-account>\n");

$data = aws_request($argv[1], "ec2 describe-instances");

foreach ($data["Reservations"] as $reservation) {
	aws_decode_reservation($reservation);
}
