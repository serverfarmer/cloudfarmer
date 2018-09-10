#!/bin/sh

/opt/farm/scripts/setup/extension.sh sf-farm-manager
/opt/farm/scripts/setup/extension.sh sf-farm-provisioning
/opt/farm/scripts/setup/extension.sh sf-php

if [ ! -d /opt/polynimbus ]; then
	git clone https://github.com/polynimbus/polynimbus /opt/polynimbus
fi

/opt/polynimbus/install.sh
