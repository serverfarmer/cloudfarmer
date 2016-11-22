#!/usr/bin/php
<?php

require_once "/opt/cloud/providers/e24cloud/include.php";


if ($argc < 2)
	die("usage: $argv[0] <ssh-key-name>\n");

$name = $argv[1];
$file = "/etc/local/.ssh/id_e24_$name";

if (file_exists($file))
	die("error: ssh key $name already exists\n");

$e24 = e24client();
$response = $e24->create_key_pair($name);

if (empty($response->body->keyMaterial))
	die("error: cannot create ssh key $name\n");

file_put_contents($file, (string)$response->body->keyMaterial);
chmod($file, 0600);
