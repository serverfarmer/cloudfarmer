#!/bin/sh
. /opt/cloud/credentials/rackspace.sh

rack servers instance list --profile $RACKSPACE_PROFILE_NAME
