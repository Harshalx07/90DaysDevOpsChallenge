#!/bin/bash

set -euo pipefail

system_info() {
    echo "===== SYSTEM INFO ====="
    hostname
    uname -a
    echo
}

uptime_info() {
    echo "===== UPTIME ====="
    uptime
    echo
}

disk_usage() {
    echo "===== DISK USAGE ====="
    du -sh /* 2>/dev/null | sort -hr | head -5
    echo
}

memory_usage() {
    echo "===== MEMORY USAGE ====="
    free -h
    echo
}

cpu_processes() {
    echo "===== TOP CPU PROCESSES ====="
    ps aux --sort=-%cpu | head -6
    echo
}

main() {
    system_info
    uptime_info
    disk_usage
    memory_usage
    cpu_processes
}

main