<?php

require_once "sdk-1.6.2/sdk.class.php";

function read_variable($account, $var)
{
	return trim(shell_exec(". /etc/local/.cloud/e24cloud/$account.sh; echo \$$var"));
}

function e24client($account)
{
	$key = read_variable($account, "E24CLOUD_API_KEY");
	$secret = read_variable($account, "E24CLOUD_API_SECRET");
	$region = read_variable($account, "E24CLOUD_REGION");

	$e24 = new AmazonEC2(array(
		"key" => $key,
		"secret" => $secret,
	));

	$host = "https://$region.api.e24cloud.com";
	$e24->set_hostname($host);

	return $e24;
}
