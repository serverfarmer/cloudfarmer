#!/bin/sh
. /opt/farm/scripts/functions.dialog

if [ "`azure account list |grep Enabled`" = "" ]; then
	azure login
fi

if [ -f /etc/local/.cloud/default/azure.sh ]; then
	exit 0
fi

REGION="`input \"enter azure region to use\" eastus`"
DEFAULT_INSTANCE_TYPE="`input \"enter azure default instance type\" Standard_A2`"

mkdir -p /etc/local/.cloud/default
echo "#!/bin/sh
#
# Azure requires \"azure\" command line client. This tool allows using multiple
# Azure accounts, however it doesn't allow choosing between them in any other
# way than described here:
#
# https://docs.microsoft.com/pl-pl/azure/xplat-cli-connect#multiple-subscriptions
#
############################################################################
#
# Default region to use:
#
export AZURE_REGION=$REGION
#
# Ubuntu publisher and offer keys (mostly you don't need to change them):
#
export AZURE_PUBLISHER=Canonical
export AZURE_OFFER=UbuntuServer
#
# Ubuntu image version to use for new instances (use list-images.sh script
# to discover all Ubuntu versions available at your configured region):
#
export AZURE_SKU=16.04.0-LTS
#
# Default instance type to use, when type isn't explicitely specified
# (use list-instance-types.sh script to discover all instance types):
#
export AZURE_DEFAULT_INSTANCE_TYPE=$DEFAULT_INSTANCE_TYPE
" >/etc/local/.cloud/default/azure.sh
chmod 0600 /etc/local/.cloud/default/azure.sh
