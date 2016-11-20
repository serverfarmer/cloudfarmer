#!/usr/bin/php
<?php
require_once "/opt/cloud/providers/azure/include.php";

$cache = "/root/.azure/group.list";

if (file_exists($cache) && time()-filemtime($cache) < 3600)
	$json = file_get_contents($cache);
else {
	$json = shell_exec("azure group list --json");
	file_put_contents($cache, $json);
}

$data = json_decode($json, true);

foreach ($data as $group)
{
	$name = $group["name"];
	$location = $group["location"];

	if (empty($argv[1]) || !strcasecmp($argv[1], $location))
		echo "$name\n";
}
