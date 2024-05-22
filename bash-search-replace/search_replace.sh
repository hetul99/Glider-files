#!/bin/bash

# Check if the correct number of arguments are provided
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 input_file"
  exit 1
fi

input_file=$1
output_file="${input_file}.new"

# Replace all occurrences of "SEARCH" with "REPLACE" and write to the new file
sed 's/SEARCH/REPLACE/g' "$input_file" > "$output_file"

echo "All occurrences of 'SEARCH' have been replaced with 'REPLACE' in $output_file"
