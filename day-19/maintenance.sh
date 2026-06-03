#!/bin/bash

LOGFILE=/var/log/maintenance.log

echo "$(date) - Maintenance Started" >> "$LOGFILE"

./log_rotate.sh /var/log >> "$LOGFILE" 2>&1

./backup.sh ~/Documents ~/backups >> "$LOGFILE" 2>&1

echo "$(date) - Maintenance Finished" >> "$LOGFILE"