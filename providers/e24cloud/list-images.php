#!/usr/bin/php
<?php

require_once "/opt/cloud/providers/e24cloud/include.php";


$e24 = e24client();
$response = $e24->describe_images();

$images = array();
foreach ($response->body->imagesSet->item as $item) {
	$id = (string)$item->imageId;
	$images[$id] = (string)$item->name;
}

asort($images);

foreach ($images as $id => $name)
	echo "$id\t$name\n";
