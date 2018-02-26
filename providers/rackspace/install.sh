#!/bin/sh
# https://developer.rackspace.com/docs/rack-cli/

if [ "`uname`" != "Linux" ] || [ "`uname -m`" != "x86_64" ]; then
	echo "error: unsupported platform"
	exit 1
fi

if [ ! -x /usr/local/bin/rack ] || [ "`md5sum /usr/local/bin/rack |cut -f1 -d' '`" != "2c5f98ddc54d66d1ed0fd071094ec6ba" ]; then
	wget -O /usr/local/bin/rack https://ec4a542dbf90c03b9f75-b342aba65414ad802720b41e8159cf45.ssl.cf5.rackcdn.com/1.2/Linux/amd64/rack
	chmod +x /usr/local/bin/rack
fi
