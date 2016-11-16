#!/bin/bash
. /root/variables.sh

export SF_UNATTENDED=yes
export DEBIAN_FRONTEND=noninteractive
export LANG=C
export LC_ALL=C

apt-get update
apt-get upgrade -y
apt-get install -y git
git clone https://github.com/$SF_GITHUB/serverfarmer /opt/farm

HOST=$1
OSVER=`/opt/farm/scripts/config/detect-system-version.sh`
OSTYPE=`/opt/farm/scripts/config/detect-system-version.sh -type`
HWTYPE=`/opt/farm/scripts/config/detect-hardware-type.sh`
HSTYPE=`/opt/farm/scripts/config/detect-hostname-type.sh $HOST`

if [ ! -d /opt/farm/dist/$OSVER ]; then
	echo "error: something is wrong with operating system version, aborting install"
	exit 1
fi

if [ "$HSTYPE" != "hostname" ]; then
	HOST=`hostname`
	echo "warning: given hostname $1 has invalid format, continuing with the current server hostname $HOST"
else
	cp -a /etc/hostname /etc/hostname.orig
	/opt/farm/scripts/setup/hostname.sh $HOST
fi

echo "HOST=$HOST" >/etc/farmconfig
echo "OSVER=$OSVER" >>/etc/farmconfig
echo "OSTYPE=$OSTYPE" >>/etc/farmconfig
echo "HWTYPE=$HWTYPE" >>/etc/farmconfig
echo "SMTP=true" >>/etc/farmconfig
echo "SYSLOG=true" >>/etc/farmconfig

mkdir -p   /etc/local/.config /etc/local/.ssh
chmod 0700 /etc/local/.config /etc/local/.ssh
chmod 0711 /etc/local

/opt/farm/scripts/setup/groups.sh
/opt/farm/setup.sh

/sbin/ifconfig -a |mail -s "Cloud instance $HOST setup finished" $SF_CONFIRM
