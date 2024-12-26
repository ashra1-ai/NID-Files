#!/bin/bash

LOG_FILE="fast.log"

if [ $# -eq 0 ]; then
  echo "Error: No alert string provided"
  echo "Usage: $0 \"alert string to search\""
  exit 1
fi

ALERT_STRING="$1"

if [ ! -f "$LOG_FILE" ]; then
  echo "Error: Log file not found at $LOG_FILE"
  exit 1
fi

# Check if the alert string is present in the last 3 lines of the log file
if grep -qi "$ALERT_STRING" <(tail -n 3 "$LOG_FILE"); then
  echo "Alert found in last 3 entries: $ALERT_STRING"
  exit 0
else
  echo "Alert not found in last 3 entries"
  exit 1
fi