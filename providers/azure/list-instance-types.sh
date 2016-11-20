#!/bin/sh
. /opt/cloud/credentials/azure.sh

azure vm sizes --location $AZURE_REGION
