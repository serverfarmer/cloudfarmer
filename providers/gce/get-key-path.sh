#!/bin/sh

key=/etc/local/.ssh/id_gce_$1

if [ -f $key ]; then
	echo $key
else
	echo "-"
fi
