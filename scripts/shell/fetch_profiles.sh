#!/bin/bash

# Script to fetch content from URLs in the last column of a CSV file
# and concatenate them into one output file
# Usage: ./fetch_profiles.sh <input_csv_file> [output_file]

if [[ $# -lt 1 ]]; then
    echo "Usage: $0 <input_csv_file> [output_file]"
    echo "Example: $0 Shines_Profile.csv combined_profiles.txt"
    exit 1
fi

INPUT_FILE="$1"
OUTPUT_FILE="${2:-combined_profiles.txt}"

if [[ ! -f "$INPUT_FILE" ]]; then
    echo "Error: File '$INPUT_FILE' not found" >&2
    exit 1
fi

> "$OUTPUT_FILE"

count=0
total=$(tail -n +2 "$INPUT_FILE" | wc -l | xargs)
echo "$total"

while IFS= read -r line; do
    # Extract the last column (URL) and strip whitespace and carriage returns
    url=$(echo "$line" | awk -F',' '{print $NF}' | xargs | tr -d '\r')
    
    if [[ -z "$url" || ! "$url" =~ ^https?:// ]]; then
        continue
    fi
    
    count=$((count + 1))
    echo "[$count/$total] Fetching: $url" >&2
    
    temp_file=$(mktemp)
    curl_exit_code=0
    curl -kL --connect-timeout 10 --max-time 30 "$url" > "$temp_file" 2>/dev/null || curl_exit_code=$?
    
    if [[ $curl_exit_code -eq 0 && -s "$temp_file" ]]; then
        cat "$temp_file" | html2text >> "$OUTPUT_FILE"
        echo -e "\n\n=== END OF $url ===\n" >> "$OUTPUT_FILE"
        echo "✓ Success" >&2
    else
        echo "✗ Warning: Failed to fetch $url or no content received" >&2
    fi
    rm -f "$temp_file"
done < <(tail -n +2 "$INPUT_FILE")

echo "Done! Combined profiles saved to: $OUTPUT_FILE" >&2
