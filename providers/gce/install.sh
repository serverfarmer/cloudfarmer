#!/bin/sh
# https://cloud.google.com/sdk/downloads

if [ "`which gcloud 2>/dev/null`" != "" ]; then
	gcloud components update
else
	curl https://sdk.cloud.google.com |bash
fi
