#!/bin/bash
. /opt/farm/scripts/functions.dialog

if [ "`which gcloud 2>/dev/null`" = "" ]; then
	if [ -f '/root/google-cloud-sdk/path.bash.inc' ]; then . '/root/google-cloud-sdk/path.bash.inc'; fi
	if [ -f '/root/google-cloud-sdk/completion.bash.inc' ]; then . '/root/google-cloud-sdk/completion.bash.inc'; fi
fi

if [ ! -d /root/.config/gcloud ]; then
	gcloud init
fi

if [ "`gcloud auth list 2>/dev/null |grep ACTIVE`" = "" ]; then
	gcloud auth login
fi

if [ -f /etc/local/.cloud/default/gce.sh ]; then
	exit 0
fi

REGION="`input \"enter GCE region to use\" europe-west1-c`"
DEFAULT_INSTANCE_TYPE="`input \"enter GCE default instance type\" n1-standard-1`"

mkdir -p /etc/local/.cloud/default
echo "#!/bin/sh
#
# Google Compute Engine requires \"gcloud\" command line client, a part of
# Google Cloud SDK. This tool, as opposite to command line clients for other
# cloud services, doesn't support multiple profiles.
#
############################################################################
#
# Default region to use:
#
export GCE_REGION=$REGION
#
# Ubuntu family and project (Cloud Farmer was tested with debian-8,
# ubuntu-1404-lts and ubuntu-1604-lts):
#
export GCE_FAMILY=ubuntu-1604-lts
export GCE_PROJECT=ubuntu-os-cloud
#
# Default instance type to use, when type isn't explicitely specified
# (use list-instance-types.sh script to discover all instance types):
#
export GCE_DEFAULT_INSTANCE_TYPE=$DEFAULT_INSTANCE_TYPE
" >/etc/local/.cloud/default/gce.sh
chmod 0600 /etc/local/.cloud/default/gce.sh
