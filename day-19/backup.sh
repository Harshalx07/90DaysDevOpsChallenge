#!/bin/bash

set -euo pipefail

SOURCE=$1
DESTINATION=$2

if [ ! -d "$SOURCE" ]; then
    echo "Error: Source directory does not exist"
    exit 1
fi

mkdir -p "$DESTINATION"

DATE=$(date +%Y-%m-%d)
ARCHIVE="$DESTINATION/backup-$DATE.tar.gz"

tar -czf "$ARCHIVE" "$SOURCE"

if [ -f "$ARCHIVE" ]; then
    echo "Backup created successfully"
    echo "Archive: $ARCHIVE"
    du -h "$ARCHIVE"
else
    echo "Backup failed"
    exit 1
fi

find "$DESTINATION" -name "*.tar.gz" -mtime +14 -delete