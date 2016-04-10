#!/bin/bash
. /opt/farm/scripts/functions.custom

target=$1
tmpkey=$2
path=/opt/cloud

ssh -i $tmpkey -o StrictHostKeyChecking=no -o PasswordAuthentication=no ubuntu@$target uptime >/dev/null 2>/dev/null

if [[ $? != 0 ]]; then
	echo "error: host $target denied access"
	exit 1
fi

log=$path/logs/$target.log
echo "### BEGIN `date +'%Y-%m-%d %H:%M:%S'` ###" >>$log

ssh -i $tmpkey ubuntu@$target "cat /home/ubuntu/.ssh/authorized_keys |sudo tee /root/.ssh/authorized_keys >/dev/null" >>$log

# install Server Farmer
scp -i $tmpkey $path/credentials/variables.sh $path/providers/ec2/setup-server-farmer.sh root@$target:/root >>$log
ssh -i $tmpkey root@$target /root/setup-server-farmer.sh $target >>$log 2>>$log

echo "### END `date +'%Y-%m-%d %H:%M:%S'` ###" >>$log

# add instance to server farm
if [ -x /opt/farm/ext/farm-manager/add-dedicated-key.sh ]; then
	/opt/farm/ext/farm-manager/add-dedicated-key.sh $target root
	/opt/farm/ext/farm-manager/add-dedicated-key.sh $target backup

	if [ -x /opt/farm/ext/backup-collector/add-backup-host.sh ]; then
		/opt/farm/ext/backup-collector/add-backup-host.sh $target
	fi
fi

echo $target >>/etc/local/.config/backup.hosts
echo $target >>/etc/local/.config/ec2.hosts
