#!/bin/sh
. /etc/local/.cloud/default/azure.sh

if [ "$1" = "" ]; then
	echo "usage: $0 <ssh-key-name> [instance-type]"
	exit 1
fi

key=$1
random=`date +%s |md5sum |head -c 4`
group=farm_$AZURE_REGION

if [ "$2" != "" ]; then
	type=$2
else
	type=$AZURE_DEFAULT_INSTANCE_TYPE
fi

if [ "`/opt/cloud/providers/azure/list-groups.php |grep -Fx $group`" = "" ]; then
	azure group create --name $group --location $AZURE_REGION
	rm -f /root/.azure/group.list
fi

azure vm quick-create \
	--name $key-$random \
	--vm-size $type \
	--resource-group $group \
	--os-type Linux \
	--location $AZURE_REGION \
	--image-urn $AZURE_PUBLISHER:$AZURE_OFFER:$AZURE_SKU:latest \
	--admin-username ubuntu \
	--ssh-publickey-file /etc/local/.ssh/id_azure_$key.pub \
	--public-ip-domain-name $key-$random \
	--json \
	|/opt/cloud/providers/azure/instance.php

# deleting unneeded instances:
# azure vm delete --name test03-48d1 --resource-group FARM_EASTUS
