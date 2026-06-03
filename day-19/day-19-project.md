# Day 19 - Shell Scripting Project

## Task 1: Log Rotation Script

Features:
- Compresses .log files older than 7 days
- Deletes .gz files older than 30 days
- Counts compressed and deleted files
- Validates directory existence

## Task 2: Backup Script

Features:
- Creates timestamped archive
- Verifies backup creation
- Shows archive size
- Deletes backups older than 14 days
- Validates source directory

## Task 3: Cron Jobs

Daily Log Rotation:

0 2 * * * /home/user/2026/day-19/log_rotate.sh /var/log

Weekly Backup:

0 3 * * 0 /home/user/2026/day-19/backup.sh /source /backup

Health Check Every 5 Minutes:

*/5 * * * * /home/user/health_check.sh

## Task 4: Maintenance Script

Features:
- Runs log rotation
- Runs backup
- Writes output to maintenance.log
- Scheduled daily at 1 AM

Cron Entry:

0 1 * * * /home/user/2026/day-19/maintenance.sh

## Sample Output

Files compressed: 5
Files deleted: 2

Backup created successfully
Archive: backup-2026-06-03.tar.gz
Size: 15M

## What I Learned

1. Automating log management using shell scripting.
2. Creating compressed backups with tar and gzip.
3. Scheduling recurring tasks using cron jobs.