#!/usr/bin/php
<?php
require_once "/opt/cloud/providers/ec2/include.php";

if ($argc < 2)
	die("usage: $argv[0] <awscli-profile-name>\n");

$data = aws_request($argv[1], "ec2 describe-key-pairs");

foreach ($data["KeyPairs"] as $pair)
	echo $pair["KeyName"]."\n";
