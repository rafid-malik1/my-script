#!/bin/bash

# Your name
NAME="Rafid"

# Timestamp for log file
timestamp=$(date +"%Y%m%d_%H%M%S")
logfile="system_info_${timestamp}.log"

# Collect system information
hostname=$(hostname)
cpu_model=$(grep -m 1 "model name" /proc/cpuinfo | cut -d ':' -f2 | xargs)
cpu_count=$(nproc)
mem_total=$(grep MemTotal /proc/meminfo | awk '{print $2}')
mem_total_gb=$(echo "scale=2; $mem_total/1024/1024" | bc)
os_info=$(lsb_release -d | cut -f2)
storage_total=$(df -h --total | grep total | awk '{print $2}')

# Prepare output
output="""
===========================================
        System Information Summary
===========================================
Your Name: $NAME

System Name: $hostname

CPU Information:
    Model: $cpu_model
    Total CPUs: $cpu_count

Memory Information:
    Total Memory (RAM): ${mem_total_gb} GB

Operating System Information:
    OS: $os_info

Storage Information:
    Total SSD Storage: $storage_total
===========================================
"""

# Display output
echo "$output"

# Save output to log file
echo "$output" > "$logfile"

# Notify user
echo "System information saved to $logfile"

