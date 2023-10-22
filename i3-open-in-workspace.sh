#!/usr/bin/env bash

if [ "$#" -lt 2 ]; then
	echo "Usage: i3-open-in-workspace.sh <program> <workspace>"
	exit 1
fi

PROGRAM=$1
WORKSPACE=$2

i3-msg "workspace $WORKSPACE; exec $PROGRAM"
