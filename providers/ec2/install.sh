#!/bin/sh
. /opt/farm/scripts/functions.install

# http://docs.aws.amazon.com/cli/latest/userguide/installing.html

install_deb libyaml-dev
install_deb python-yaml
install_deb python-pip

if [ "`pip list |grep awscli`" = "" ]; then
	pip install awscli
else
	pip install --upgrade awscli
fi
