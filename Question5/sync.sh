#!/bin/bash

DIRA="dirA"
DIRB="dirB"

# Check if directories exist
if [ ! -d "$DIRA" ] || [ ! -d "$DIRB" ]; then
    echo "Error: One or both directories do not exist."
    exit 1
fi

echo "Files only in $DIRA:"
echo "-------------------"
ls "$DIRA" | grep -vF -f <(ls "$DIRB")

echo
echo "Files only in $DIRB:"
echo "-------------------"
ls "$DIRB" | grep -vF -f <(ls "$DIRA")

echo
echo "Comparing common files:"
echo "----------------------"

for file in $(ls "$DIRA")
do
    if [ -f "$DIRB/$file" ]; then
        cmp -s "$DIRA/$file" "$DIRB/$file"
        if [ $? -eq 0 ]; then
            echo "$file : Contents match"
        else
            echo "$file : Contents differ"
        fi
    fi
done

