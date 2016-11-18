#!/bin/sh
. /opt/cloud/credentials/rackspace.sh

rack servers flavor list --profile $RACKSPACE_PROFILE_NAME
