#!/bin/sh
. /opt/cloud/credentials/rackspace.sh

rack servers image list --profile $RACKSPACE_PROFILE_NAME
