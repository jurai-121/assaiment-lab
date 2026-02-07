#!/bin/bash

# Check if exactly one argument is provided
if [ "$#" -ne 1 ]; then
    echo "Error: Please provide exactly one directory path."
    exit 1
fi

DIR="$1"

# Check if directory exists
if [ ! -d "$DIR" ]; then
    echo "Error: Directory does not exist."
    exit 1
fi

# Create backup directory
mkdir -p "$DIR/backup"

echo "Parent Script PID: $$"
echo "Moving files to backup directory in background..."

# Move each file in background
for file in "$DIR"/*
do
    if [ -f "$file" ]; then
        mv "$file" "$DIR/backup/" &
        echo "Started moving $(basename "$file") with PID: $!"
    fi
done

# Wait for all background processes to complete
wait

echo "All background move operations completed."

