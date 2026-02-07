#!/bin/bash

# Check if emails.txt exists
if [ ! -f "emails.txt" ]; then
    echo "Error: emails.txt file not found."
    exit 1
fi

# Extract valid email addresses
grep -E '^[a-zA-Z0-9]+@[a-zA-Z]+\.com$' emails.txt | sort | uniq > valid.txt

# Extract invalid email addresses
grep -Ev '^[a-zA-Z0-9]+@[a-zA-Z]+\.com$' emails.txt > invalid.txt

echo "Email cleaning completed."
echo "Valid emails saved in valid.txt"
echo "Invalid emails saved in invalid.txt"

