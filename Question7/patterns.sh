#!/bin/bash

# Check if input file exists
if [ ! -f "input.txt" ]; then
    echo "Error: input.txt file not found."
    exit 1
fi

# Clear output files
> vowels.txt
> consonants.txt
> mixed.txt

# Read words from file
while read -r word
do
    # Convert word to lowercase
    w=$(echo "$word" | tr 'A-Z' 'a-z')

    # Only vowels
    if echo "$w" | grep -Eq '^[aeiou]+$'; then
        echo "$word" >> vowels.txt

    # Only consonants
    elif echo "$w" | grep -Eq '^[bcdfghjklmnpqrstvwxyz]+$'; then
        echo "$word" >> consonants.txt

    # Mixed but starting with consonant
    elif echo "$w" | grep -Eq '^[bcdfghjklmnpqrstvwxyz][a-z]*$' \
         && echo "$w" | grep -q '[aeiou]'; then
        echo "$word" >> mixed.txt
    fi

done < input.txt

echo "Pattern classification completed."

