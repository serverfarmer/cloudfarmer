#!/bin/sh
# https://docs.microsoft.com/pl-pl/azure/xplat-cli-install

if [ "`which npm 2>/dev/null`" = "" ]; then
	curl -sL https://deb.nodesource.com/setup_9.x |bash
	apt-get install -y nodejs
fi

if [ "`which azure 2>/dev/null`" = "" ]; then
	npm install -g azure-cli
else
	npm update -g azure-cli
fi
