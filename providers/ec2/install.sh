#!/bin/sh
# http://docs.aws.amazon.com/cli/latest/userguide/installing.html

/opt/farm/ext/repos/package/install.sh libyaml-dev
/opt/farm/ext/repos/package/install.sh python-yaml
/opt/farm/ext/repos/package/install.sh python-pip

if [ "`pip list |grep awscli`" = "" ]; then
	pip install awscli
else
	pip install --upgrade awscli
fi
