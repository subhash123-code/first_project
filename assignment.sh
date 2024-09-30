#!/usr/bin/env bash



echo "Enter the option number to execute:"
read option

if [ $option -eq 1 ]
then

# File paths
TEXT_FILE="expected.txt"
cd students/
cd 
SCRIPT_FILE=".txt"

# Check if both files exist
if [ ! -f "$expected.txt" ]; then
    echo "Error: $expected.txt not found!"
    exit 1
fi

if [ ! -f "$SCRIPT_FILE" ]; then
    echo "Error: $SCRIPT_FILE not found!"
    exit 1
fi

# Count matching lines and wrong lines
MATCH_COUNT=$(gawk 'NR==FNR { lines[$0]++; next } $0 in lines { count++ } END { print count }' "$TEXT_FILE" "$SCRIPT_FILE")
TOTAL_SCRIPT_LINES=$(wc -l < "$SCRIPT_FILE")
EXTRA_LINES=$(gawk 'NR==FNR { lines[$0]++; next } $0 !in lines' "$TEXT_FILE" "$SCRIPT_FILE" | wc -l)
WRONG_LINES=$((TOTAL_SCRIPT_LINES - MATCH_COUNT + EXTRA_LINES))

# Output the results
echo "Number of matching lines: $MATCH_COUNT"
echo "Number of wrong lines: $WRONG_LINES"

	
fi

read -p "Enter roll number: " ROLL_NUMBER
cd assignment/
TEXT_FILE="student_details.txt"

if [ ! -f "$TEXT_FILE" ]; then
    echo "Error: $TEXT_FILE not found!"
    exit 1
fi

STUDENT_NAME=$(gawk -v roll="$ROLL_NUMBER" '$1 == roll { $1=""; print substr($0,2) }' "$TEXT_FILE")

if [ -z "$STUDENT_NAME" ]; then
    echo "No student found with roll number $ROLL_NUMBER"
else
    echo "Student Name: $STUDENT_NAME"
fi




fi 


