#!/bin/bash

if [ $# -ne 2 ]; then
    echo "Usage: $0 <input_dir> <output_dir>"
    exit 1
fi

input_dir=$1
output_dir=$2

if [ ! -d "$input_dir" ]; then
    echo "Input directory does not exist: $input_dir"
    exit 1
fi

if [ ! -d "$output_dir" ]; then
    mkdir -p "$output_dir"
fi

find "$input_dir" -maxdepth 1 -type f
find "$input_dir" -maxdepth 1 -type d


find "$input_dir" -type f | while read file; do
    base_name=$(basename "$file")

    timestamp=$(date +%s%N) 
    destination="$output_dir/${base_name%.*}_$timestamp.${base_name##*.}"

    cp "$file" "$destination"
    if [ $? -ne 0 ]; then
        echo "Error copying file $file to $destination"
    fi
done

echo "Files have been copied to $output_dir"