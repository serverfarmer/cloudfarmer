#!/bin/sh
#
# Azure requires "azure" command line client. This tool allows using multiple
# Azure accounts, however it doesn't allow choosing between them in any other
# way than described here:
#
# https://docs.microsoft.com/pl-pl/azure/xplat-cli-connect#multiple-subscriptions
#
############################################################################
#
# Default region to use:
#
export AZURE_REGION=eastus
#
# Ubuntu publisher and offer keys (mostly you don't need to change them):
#
export AZURE_PUBLISHER=Canonical
export AZURE_OFFER=UbuntuServer
#
# Ubuntu image version to use for new instances (use list-images.sh script
# to discover all Ubuntu versions available at your configured region):
#
export AZURE_SKU=16.04.0-LTS
#
# Default instance type to use, when type isn't explicitely specified
# (use list-instance-types.sh script to discover all instance types):
#
export AZURE_DEFAULT_INSTANCE_TYPE=Standard_A2
