#!/bin/sh
. /etc/local/.cloud/default/azure.sh

azure vm sizes --location $AZURE_REGION
