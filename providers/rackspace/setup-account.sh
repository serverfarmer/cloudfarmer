#!/bin/sh
. /opt/farm/scripts/functions.dialog

if [ "$1" = "" ]; then
	echo "usage: $0 <cloud-account>"
	exit 1
elif [ -f /etc/local/.cloud/$1/rackspace.sh ]; then
	echo "error: cloud account \"$1\" already configured"
	exit 1
fi

account=$1
rack configure

if ! grep -q "\[$account\]" /root/.rack/config; then
	echo "error: cloud account \"$account\" left unconfigured"
	exit 1
fi

DEFAULT_INSTANCE_TYPE="`input \"enter Rackspace default instance type\" 2`"

mkdir -p /etc/local/.cloud/$account
echo "#!/bin/sh
#
# Rackspace Cloud requires \"rack\" command line client. You can find more
# information about this tool here:
#
#    https://developer.rackspace.com/docs/rack-cli/
#
# This variable should point to valid, configured Rackspace Cloud profile.
#
export RACKSPACE_PROFILE_NAME=$account
#
#
############################################################################
#
# Ubuntu 14.04 LTS or 16.04 LTS image name (use list-images.sh script to
# discover all images available at your configured region):
#
export RACKSPACE_IMAGE_NAME=\"Ubuntu 14.04 LTS (Trusty Tahr) (PVHVM)\"
#
# Default instance type to use, when type isn't explicitely specified
# (use list-instance-types.sh script to discover all instance types):
#
export RACKSPACE_DEFAULT_INSTANCE_TYPE=$DEFAULT_INSTANCE_TYPE
" >/etc/local/.cloud/$account/rackspace.sh
chmod 0600 /etc/local/.cloud/$account/rackspace.sh
