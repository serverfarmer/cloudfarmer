#!/bin/sh

key=/etc/local/.ssh/id_rack_$1

if [ -f $key ]; then
	echo $key
else
	exit 1
fi
