#!/bin/bash

PASS_MARK=33
one_fail=0
all_pass=0

echo "Students who failed in exactly ONE subject:"
echo "-----------------------------------------"

while IFS=',' read -r roll name m1 m2 m3
do
    # Skip empty lines
    [ -z "$roll" ] && continue

    # Trim spaces
    roll=$(echo "$roll" | xargs)
    name=$(echo "$name" | xargs)
    m1=$(echo "$m1" | xargs)
    m2=$(echo "$m2" | xargs)
    m3=$(echo "$m3" | xargs)

    fail_count=0

    [ "$m1" -lt "$PASS_MARK" ] && fail_count=$((fail_count + 1))
    [ "$m2" -lt "$PASS_MARK" ] && fail_count=$((fail_count + 1))
    [ "$m3" -lt "$PASS_MARK" ] && fail_count=$((fail_count + 1))

    if [ "$fail_count" -eq 1 ]; then
        echo "$roll, $name"
        one_fail=$((one_fail + 1))
    fi

    if [ "$fail_count" -eq 0 ]; then
        all_pass=$((all_pass + 1))
    fi

done < marks.txt

echo
echo "Students who passed in ALL subjects:"
echo "----------------------------------"

while IFS=',' read -r roll name m1 m2 m3
do
    [ -z "$roll" ] && continue

    roll=$(echo "$roll" | xargs)
    name=$(echo "$name" | xargs)
    m1=$(echo "$m1" | xargs)
    m2=$(echo "$m2" | xargs)
    m3=$(echo "$m3" | xargs)

    if [ "$m1" -ge "$PASS_MARK" ] && \
       [ "$m2" -ge "$PASS_MARK" ] && \
       [ "$m3" -ge "$PASS_MARK" ]; then
        echo "$roll, $name"
    fi

done < marks.txt

echo
echo "Summary:"
echo "--------"
echo "Students failed in exactly one subject: $one_fail"
echo "Students passed in all subjects: $all_pass"

