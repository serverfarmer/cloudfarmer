#!/bin/sh

if [ ! -d /usr/share/php/sdk-1.6.2 ]; then
	mkdir -p /usr/share/php
	cd /usr/share/php
	wget http://pear.amazonwebservices.com/get/sdk-latest.zip
	unzip -b sdk-latest.zip
fi
