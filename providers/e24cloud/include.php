<?php

require_once "sdk-1.6.2/sdk.class.php";
require_once "/opt/cloud/credentials/e24cloud.php";

function e24client()
{
	global $E24CLOUD_API_KEY;
	global $E24CLOUD_API_SECRET;
	global $E24CLOUD_REGION;

	$e24 = new AmazonEC2(array(
		"key" => $E24CLOUD_API_KEY,
		"secret" => $E24CLOUD_API_SECRET,
	));

	$host = "https://$E24CLOUD_REGION.api.e24cloud.com";
	$e24->set_hostname($host);

	return $e24;
}
