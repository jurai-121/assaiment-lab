#!/bin/bash

# Check if exactly one argument is provided
if [ "$#" -ne 1 ]; then
    echo "Error: Please provide exactly one log file as argument."
    exit 1
fi

LOGFILE="$1"

# Check if file exists
if [ ! -e "$LOGFILE" ]; then
    echo "Error: File does not exist."
    exit 1
fi

# Check if file is readable
if [ ! -r "$LOGFILE" ]; then
    echo "Error: File is not readable."
    exit 1
fi

# Count total log entries
total=$(wc -l < "$LOGFILE")

# Count log levels
info=$(grep -c " INFO " "$LOGFILE")
warning=$(grep -c " WARNING " "$LOGFILE")
error=$(grep -c " ERROR " "$LOGFILE")

# Get most recent ERROR message
recent_error=$(grep " ERROR " "$LOGFILE" | tail -n 1)

# Display results
echo "Total log entries: $total"
echo "INFO messages: $info"
echo "WARNING messages: $warning"
echo "ERROR messages: $error"

if [ -n "$recent_error" ]; then
    echo "Most recent ERROR message:"
    echo "$recent_error"
else
    echo "No ERROR messages found."
fi

# Create report file
date=$(date +"%Y-%m-%d")
report="logsummary_$date.txt"

{
    echo "Log Summary Report - $date"
    echo "---------------------------"
    echo "Total log entries: $total"
    echo "INFO messages: $info"
    echo "WARNING messages: $warning"
    echo "ERROR messages: $error"
    echo
    echo "Most recent ERROR message:"
    echo "${recent_error:-None}"
} > "$report"

echo "Report generated: $report"

