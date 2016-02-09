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

# use AWS temporary key, install main management key for root
scp -i $tmpkey $path/credentials/ssh.keys $path/providers/ec2/setup-root-keys.sh ubuntu@$target:/home/ubuntu >>$log
ssh -i $tmpkey ubuntu@$target /home/ubuntu/setup-root-keys.sh >>$log


# TODO:
# - use ec2-create-ssh-key.sh to create new key pair and upload it to EC2
# - create new EC2 instance with the new key associated
# - use the new key (instead of ssh.keys file and $admkey) below to install Server Farmer


# install Server Farmer
admkey=`ssh_management_key_storage_filename $target`

scp -i $admkey $path/credentials/variables.sh $path/providers/ec2/setup-server-farmer.sh root@$target:/root >>$log
ssh -i $admkey root@$target /root/setup-server-farmer.sh $target >>$log 2>>$log

echo "### END `date +'%Y-%m-%d %H:%M:%S'` ###" >>$log

# add instance to server farm
echo $target >>/etc/local/.config/backup.hosts
echo $target >>/etc/local/.config/ec2.hosts
