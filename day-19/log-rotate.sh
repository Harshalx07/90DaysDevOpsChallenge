#!/bin/bash

set -euo pipefail

LOG_DIR=$1

if [ ! -d "$LOG_DIR" ]; then
    echo "Error: Directory does not exist"
    exit 1
fi

compressed=0
deleted=0

while read -r file
do
    gzip "$file"
    ((compressed++))
done < <(find "$LOG_DIR" -type f -name "*.log" -mtime +7)

while read -r file
do
    rm "$file"
    ((deleted++))
done < <(find "$LOG_DIR" -type f -name "*.gz" -mtime +30)

echo "Files compressed: $compressed"
echo "Files deleted: $deleted"