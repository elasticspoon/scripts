#!/usr/bin/env bash

if [ $# -eq 0 ] || [ $# -gt 2 ]; then
	echo "Usage: service-failure-notification.sh <service_name> [notification_urgency]"
	exit 1
fi

URGENCY="normal"
SERVICE_NAME=$1

if [ $2 ]; then
	URGENCY=$2
fi

FAILURE_LOGS=$(journalctl --user-unit=$SERVICE_NAME --since "5 minutes ago" -b -n 3)

if [ -n "$FAILURE_LOGS" ] && [ "$FAILURE_LOGS" != "-- No entries --" ]; then
	FULL_LOGS=$(journalctl --user-unit=$SERVICE_NAME --since "5 minutes ago" -b)
	LOG_FILE=/tmp/$SERVICE_NAME-$(date +%Y-%m-%d-%H-%M-%S)-logs.txt
	echo "$FULL_LOGS" >$LOG_FILE
	FAILURE_LOGS="$FAILURE_LOGS\n\nFull logs: $LOG_FILE"
else
	FAILURE_LOGS="No logs found"
fi

dunstify -u $URGENCY "Service Failure: $SERVICE_NAME" "$FAILURE_LOGS"
