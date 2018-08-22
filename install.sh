#!/bin/sh

mkdir -p   /etc/local/.cloud
chmod 0700 /etc/local/.cloud

/opt/farm/scripts/setup/extension.sh sf-farm-provisioning
/opt/farm/scripts/setup/extension.sh sf-cloud-client-ec2
/opt/farm/scripts/setup/extension.sh sf-cloud-client-e24
/opt/farm/scripts/setup/extension.sh sf-cloud-client-gce
/opt/farm/scripts/setup/extension.sh sf-cloud-client-azure
/opt/farm/scripts/setup/extension.sh sf-cloud-client-rackspace
