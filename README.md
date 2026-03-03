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
├── Pipfile                      # Python dependencies
├── Pipfile.lock                 # Locked dependency versions
├── Makefile                     # Build automation
└── README.md                    # This file
```

## Getting Started with Make

This project uses a Makefile for easy setup and execution. Make sure you have `pipenv` installed.

### Quick Start

```bash
make fetch-profiles INPUT_FILE=<input_csv_name> OUTPUT_FILE=<output_file_name>
```

This will automatically create a Python virtual environment from `Pipfile.lock` and run the profile fetching script.

## Scripts

### fetch_profiles.sh

Fetches content from URLs stored in a CSV file and concatenates them into a single output file.

#### Requirements

- `bash`
- `curl`
- `python3.12`
- `html2text` - for converting HTML to plain text so the file will not hit the file character limits(500,000) of notebooklm

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
=== START OF [name] ===
[Profile content here]

=== END OF [name] ===
```

## Notes

- The script skips the header row (first row) of the CSV file
- Failed fetches are logged but don't stop the script from processing other URLs
- Temporary files are automatically cleaned up after processing
