#!/bin/sh
# http://docs.aws.amazon.com/cli/latest/userguide/installing.html

/opt/farm/ext/repos/utils/install.sh libyaml-dev python-yaml python-pip

if [ "`pip list |grep awscli`" = "" ]; then
	pip install awscli
else
	pip install --upgrade awscli
fi
