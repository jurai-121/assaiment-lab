#!/bin/bash

# Check if input file exists
if [ ! -f "input.txt" ]; then
    echo "Error: input.txt file not found."
    exit 1
fi

# Convert text to lowercase, remove punctuation, and split into words
words=$(tr -c 'a-zA-Z' '\n' < input.txt | tr 'A-Z' 'a-z' | grep -v '^$')

# Longest word
longest=$(echo "$words" | sort | awk '{ print length, $0 }' | sort -nr | head -n 1 | awk '{ print $2 }')

# Shortest word
shortest=$(echo "$words" | sort | awk '{ print length, $0 }' | sort -n | head -n 1 | awk '{ print $2 }')

# Average word length
total_chars=$(echo "$words" | wc -c)
total_words=$(echo "$words" | wc -l)
average=$(( total_chars / total_words ))

# Unique words count
unique=$(echo "$words" | sort | uniq | wc -l)

echo "Longest word: $longest"
echo "Shortest word: $shortest"
echo "Average word length: $average"
echo "Total unique words: $unique"

