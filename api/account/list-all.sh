#!/bin/sh

for PR in `ls /opt/cloud/providers`; do
	echo "$PR:"
	ACCS=`/opt/cloud/api/account/list.sh $PR`
	for acc in $ACCS; do
		echo "\t$acc"
	done
done
