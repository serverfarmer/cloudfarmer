#!/usr/bin/php
<?php

require_once "/opt/cloud/providers/e24cloud/include.php";


$e24 = e24client();
$response = $e24->describe_key_pairs();

foreach ($response->body->keySet->item as $item) {
	$name = (string)$item->keyName;
	echo "$name\n";
}
