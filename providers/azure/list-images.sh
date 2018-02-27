#!/bin/sh
. /etc/local/.cloud/azure/default.sh

azure vm image list-skus --publisher $AZURE_PUBLISHER --offer $AZURE_OFFER --location $AZURE_REGION
