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

# use AWS temporary key, install main management key for root
scp -i $tmpkey $path/credentials/ssh.keys $path/ec2/setup-root-keys.sh ubuntu@$target:/home/ubuntu
ssh -i $tmpkey ubuntu@$target /home/ubuntu/setup-root-keys.sh

# install Server Farmer
admkey=`ssh_management_key_storage_filename instance.ec2`

scp -i $admkey $path/credentials/variables.sh $path/ec2/setup-server-farmer.sh root@$target:/root
ssh -i $admkey root@$target /root/setup-server-farmer.sh $target

# add instance to server farm
echo $target >>/etc/local/.config/backup.hosts
echo $target >>/etc/local/.config/ec2.hosts
