#!/bin/sh
#
# Google Compute Engine requires "gcloud" command line client, a part of
# Google Cloud SDK. This tool, as opposite to command line clients for other
# cloud services, doesn't support multiple profiles.
#
############################################################################
#
# Default region to use:
#
export GCE_REGION=europe-west1-c
#
# Ubuntu family and project (Cloud Farmer was tested with debian-8,
# ubuntu-1404-lts and ubuntu-1604-lts):
#
export GCE_FAMILY=ubuntu-1604-lts
export GCE_PROJECT=ubuntu-os-cloud
#
# Default instance type to use, when type isn't explicitely specified
# (use list-instance-types.sh script to discover all instance types):
#
export GCE_DEFAULT_INSTANCE_TYPE=n1-standard-1
