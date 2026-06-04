#!/bin/bash

# ======================================
# Log Analyzer and Report Generator
# ======================================

# Task 1: Input Validation

if [ $# -ne 1 ]; then
    echo "Error: Please provide a log file."
    echo "Usage: $0 <log_file>"
    exit 1
fi

LOG_FILE="$1"

if [ ! -f "$LOG_FILE" ]; then
    echo "Error: File does not exist."
    exit 1
fi

DATE=$(date +%Y-%m-%d)
REPORT_FILE="log_report_${DATE}.txt"

echo "=================================="
echo "Log Analysis Started"
echo "=================================="

# Total lines
TOTAL_LINES=$(wc -l < "$LOG_FILE")

# Task 2: Error Count
ERROR_COUNT=$(grep -Ei "ERROR|Failed" "$LOG_FILE" | wc -l)

echo "Total Error Count: $ERROR_COUNT"

# Task 3: Critical Events

echo
echo "--- Critical Events ---"

CRITICAL_EVENTS=$(grep -n "CRITICAL" "$LOG_FILE")

if [ -z "$CRITICAL_EVENTS" ]; then
    echo "No critical events found."
else
    echo "$CRITICAL_EVENTS"
fi

# Task 4: Top Error Messages

echo
echo "--- Top 5 Error Messages ---"

TOP_ERRORS=$(grep "ERROR" "$LOG_FILE" \
| sed 's/.*ERROR] //' \
| sort \
| uniq -c \
| sort -rn \
| head -5)

if [ -z "$TOP_ERRORS" ]; then
    echo "No ERROR messages found."
else
    echo "$TOP_ERRORS"
fi

# Task 5: Generate Report

{
echo "=================================="
echo "Daily Log Analysis Report"
echo "=================================="
echo "Date of Analysis: $DATE"
echo "Log File: $LOG_FILE"
echo "Total Lines Processed: $TOTAL_LINES"
echo "Total Error Count: $ERROR_COUNT"
echo

echo "--- Top 5 Error Messages ---"
echo "$TOP_ERRORS"
echo

echo "--- Critical Events ---"
if [ -z "$CRITICAL_EVENTS" ]; then
    echo "No critical events found."
else
    echo "$CRITICAL_EVENTS"
fi

} > "$REPORT_FILE"

echo
echo "Report generated: $REPORT_FILE"

# Task 6: Archive Processed Logs

mkdir -p archive

mv "$LOG_FILE" archive/

echo "Log file moved to archive/"
echo "Analysis Complete"