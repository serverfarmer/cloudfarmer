<?php

function aws_client($profile = "default")
{
	$_profile = escapeshellarg($profile);
	return "/usr/local/bin/aws --profile $_profile";
}

function aws_request($profile, $request)
{
	$aws = aws_client($profile);
	$json = shell_exec("$aws $request");
	$data = json_decode($json, true);

	if (empty($data))
		die("error\n");

	return $data;
}
