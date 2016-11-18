#!/bin/sh
#
# Rackspace Cloud requires "rack" command line client. You can find more
# information about this tool here:
#
#    https://developer.rackspace.com/docs/rack-cli/
#
# This variable should point to valid, configured Rackspace Cloud profile.
# Note that Cloud Farmer doesn't work with default, nameless profile, only
# with named profiles (eg. "default", "myprofile").
#
export RACKSPACE_PROFILE_NAME=default
#
#
############################################################################
#
# Ubuntu 14.04 LTS or 16.04 LTS image name (use list-images.sh script to
# discovers all images available at your configured region):
#
export RACKSPACE_IMAGE_NAME="Ubuntu 14.04 LTS (Trusty Tahr) (PVHVM)"
#
# Default instance type to use, when type isn't explicitely specified
# (use list-instance-types.sh script to discover all instance types):
#
export RACKSPACE_DEFAULT_INSTANCE_TYPE=2
