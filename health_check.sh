#!/bin/bash

log_file="health_report.log"
cpu_usage=$(top -l 1 | awk '/CPU usage/ {print $3}' | cut -d'%' -f1)
mem_usage=$(vm_stat | awk '/Pages free/ {print $3}' | sed 's/\.//')

echo "System Health Report - $(date)" >> $log_file
echo "CPU Usage: $cpu_usage%" >> $log_file
echo "Memory Free: $mem_usage pages" >> $log_file

if (( $(echo "$cpu_usage > 80" | bc -l) )); then
    echo "WARNING: High CPU usage detected!" >> $log_file
fi

echo "----------------------------" >> $log_file
