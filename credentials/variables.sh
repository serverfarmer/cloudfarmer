#!/bin/sh
#
# Settings to use in unattended setup mode; please fill in all variables.
#
# If you eg. don't need NewRelic, or have any other needs, please adjust
# default_extensions function in /opt/farm/scripts/functions.custom file
# in your fork of Server Farmer main repository.
#
# extensions part:
#
export NEWRELIC_LICENSE=1234567890abcde1234567890abcde1234567890
export SNMP_COMMUNITY=YourSnmpCommunityName
#
# core SF part:
#
export SMTP_RELAY=smtp.gmail.com
export SMTP_USERNAME=myuser@gmail.com
export SMTP_PASSWORD=mypassword
#
# Github username (or organization short name), where you have forked
# Server Farmer main repository.
#
export SF_GITHUB=serverfarmer
#
# Email address for confirmations about successful setups.
#
export SF_CONFIRM=serverfarmer-confirm@tomaszklim.pl
