#!/bin/sh
. /opt/farm/scripts/functions.dialog

if [ "$1" = "" ]; then
	echo "usage: $0 <cloud-account>"
	exit 1
elif [ -f /etc/local/.cloud/$1/e24cloud.sh ]; then
	echo "error: cloud account \"$1\" already configured"
	exit 1
fi


API_KEY="`input \"enter e24cloud api key\" put-your-key-here`"
API_SECRET="`input \"enter e24cloud api secret\" put-your-secret-here`"

REGION="`input \"enter e24cloud region to use\" eu-poland-1poznan`"
DEFAULT_INSTANCE_TYPE="`input \"enter e24cloud default instance type\" m1.small`"

mkdir -p /etc/local/.cloud/$1
echo "#!/bin/sh
#
# e24cloud.com API key and secret:
#
export E24CLOUD_API_KEY=$API_KEY
export E24CLOUD_API_SECRET=$API_SECRET
#
# region to use (eu-poland-1poznan or eu-poland-1warszawa):
#
export E24CLOUD_REGION=$REGION
#
# Ubuntu 14.04 LTS image id:
#
export E24CLOUD_AMI_ID=ami-000006d8
#
# default instance type to use, when type isn't explicitely specified
#
export E24CLOUD_DEFAULT_INSTANCE_TYPE=$DEFAULT_INSTANCE_TYPE
" >/etc/local/.cloud/$1/e24cloud.sh
chmod 0600 /etc/local/.cloud/$1/e24cloud.sh
