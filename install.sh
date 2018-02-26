#!/bin/sh

mkdir -p   /etc/local/.cloud
chmod 0700 /etc/local/.cloud

# installing old Azure client disabled
#/opt/cloud/providers/azure/install.sh

/opt/cloud/providers/e24cloud/install.sh
/opt/cloud/providers/ec2/install.sh
/opt/cloud/providers/gce/install.sh
/opt/cloud/providers/rackspace/install.sh

/opt/farm/scripts/setup/extension.sh sf-farm-provisioning
