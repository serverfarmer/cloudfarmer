#!/bin/sh
. /opt/cloud/credentials/azure.sh

azure vm image list-skus --publisher $AZURE_PUBLISHER --offer $AZURE_OFFER --location $AZURE_REGION
