#!/usr/bin/php
<?php
require_once "/opt/cloud/providers/azure/include.php";

$data = azure_request("vm list-ip-address");

foreach ($data as $instance)
	azure_decode_instance($instance);
