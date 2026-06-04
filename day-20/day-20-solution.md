# Day 20 – Bash Scripting Challenge: Log Analyzer and Report Generator

## Objective

Create a Bash script that analyzes server log files and generates a summary report automatically.

## Script Features

### Input Validation

* Accepts log file path as command-line argument
* Checks whether argument is provided
* Verifies that the file exists

### Error Analysis

* Counts lines containing ERROR or Failed
* Displays total error count

### Critical Event Detection

* Searches for CRITICAL entries
* Displays matching lines with line numbers

### Top Error Messages

* Extracts ERROR messages
* Counts occurrences
* Displays top 5 most frequent errors

### Summary Report

Generates:

log_report_<date>.txt

Contains:

* Analysis date
* Log filename
* Total lines processed
* Error count
* Top 5 errors
* Critical events

### Log Archiving

* Creates archive directory if missing
* Moves processed log file to archive/

## Commands Used

### grep

Used for:

* Finding ERROR
* Finding Failed
* Finding CRITICAL

### wc

Used for counting:

* Total lines
* Error lines

### sort

Used for sorting error messages.

### uniq -c

Used for counting duplicate error messages.

### sed

Used for extracting only the error message text.

### mv

Used to move processed logs into archive folder.

## Sample Run

```bash
./log_analyzer.sh sample_log.log
```

Output:

```text
Total Error Count: 35

--- Critical Events ---
84: CRITICAL Disk space below threshold

--- Top 5 Error Messages ---
45 Failed to connect
32 Disk full
28 Invalid input
```

## What I Learned

1. Using grep for log analysis and pattern matching.
2. Combining sort and uniq to find most frequent entries.
3. Automating reporting and archiving tasks using Bash scripting.
