#!/bin/sh
. /etc/local/.cloud/azure/default.sh

azure vm sizes --location $AZURE_REGION
