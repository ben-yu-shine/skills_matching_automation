# Skills Matching Automation

A project for automating profile fetching and skills matching workflows.

## Overview

This repository contains tools and scripts to fetch profile data from URLs and process them for skills matching and analysis.

## Project Structure

```
skills_matching_automation/
├── scripts/
│   └── shell/
│       └── fetch_profiles.sh    # Script to fetch profiles from URLs
└── README.md                    # This file
```

## Scripts

### fetch_profiles.sh

Fetches content from URLs stored in a CSV file and concatenates them into a single output file.

#### Requirements

- `bash`
- `curl` - for fetching URLs
- `html2text` - for converting HTML to plain text

#### Usage

```bash
./scripts/shell/fetch_profiles.sh <input_csv_file> [output_file]
```

#### Arguments

- `<input_csv_file>` (required): Path to CSV file containing profile URLs in the last column
- `[output_file]` (optional): Output file path (defaults to `combined_profiles.txt`)

#### Example

```bash
./scripts/shell/fetch_profiles.sh Shines_Profile.csv combined_profiles.txt
```

#### Features

- Extracts URLs from the last column of the input CSV file
- Fetches content from each URL with a 10-second connection timeout and 30-second max time
- Converts HTML content to plain text using `html2text`
- Appends all fetched content to the output file
- Includes progress tracking and error reporting
- Skips invalid or malformed URLs
- Handles network timeouts and failures gracefully

#### Output

Each fetched profile is appended to the output file with a separator marking the end of each profile:
```
[Profile content here]

=== END OF [url] ===
```

## Getting Started

1. Prepare a CSV file with profile URLs in the last column
2. Run the fetch script:
   ```bash
   ./scripts/shell/fetch_profiles.sh your_data.csv output.txt
   ```
3. Monitor the progress as URLs are fetched
4. Review the combined output file when complete

## Notes

- The script skips the header row (first row) of the CSV file
- Failed fetches are logged but don't stop the script from processing other URLs
- Temporary files are automatically cleaned up after processing
