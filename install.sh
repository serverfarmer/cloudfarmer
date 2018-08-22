#!/bin/sh

mkdir -p   /etc/local/.cloud
chmod 0700 /etc/local/.cloud

/opt/cloud/providers/gce/install.sh
/opt/cloud/providers/rackspace/install.sh

/opt/farm/scripts/setup/extension.sh sf-farm-provisioning
/opt/farm/scripts/setup/extension.sh sf-cloud-client-ec2
/opt/farm/scripts/setup/extension.sh sf-cloud-client-e24
/opt/farm/scripts/setup/extension.sh sf-cloud-client-azure
