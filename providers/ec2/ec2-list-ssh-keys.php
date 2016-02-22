#!/usr/bin/php
<?php
require_once "/opt/cloud/providers/ec2/include.php";

$data = aws_request(aws_profile(), "ec2 describe-key-pairs");

foreach ($data["KeyPairs"] as $pair)
	echo $pair["KeyName"]."\n";
