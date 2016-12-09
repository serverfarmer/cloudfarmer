#!/usr/bin/php
<?php
require_once "/opt/cloud/providers/gce/include.php";

$data = gce_request("instances list");

foreach ($data as $instance)
	gce_decode_instance($instance);
