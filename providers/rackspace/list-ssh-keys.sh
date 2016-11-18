#!/bin/sh
. /opt/cloud/credentials/rackspace.sh

rack servers keypair list --profile $RACKSPACE_PROFILE_NAME |grep -v ^Name |cut -f 1
