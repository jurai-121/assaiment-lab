#!/bin/bash

# Check if exactly one argument is provided
if [ "$#" -ne 1 ]; then
    echo "Error: Please provide exactly one argument."
    exit 1
fi

# Check if the path exists
if [ ! -e "$1" ]; then
    echo "Error: Path does not exist."
    exit 1
fi

# If argument is a file
if [ -f "$1" ]; then
    echo "Input is a file."
    echo "Lines: $(wc -l < "$1")"
    echo "Words: $(wc -w < "$1")"
    echo "Characters: $(wc -c < "$1")"

# If argument is a directory
elif [ -d "$1" ]; then
    echo "Input is a directory."
    echo "Total files: $(find "$1" -type f | wc -l)"
    echo "Text files (.txt): $(find "$1" -type f -name "*.txt" | wc -l)"

else
    echo "Error: Invalid input."
fi

