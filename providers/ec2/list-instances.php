#!/usr/bin/php
<?php
require_once "/opt/cloud/providers/ec2/include.php";

$data = aws_request(aws_profile(), "ec2 describe-instances");

foreach ($data["Reservations"] as $reservation) {
	aws_decode_reservation($reservation);
}
