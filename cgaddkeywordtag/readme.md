# SLS Community Gallery Keyword Tagging Automation

## Overview

This TagUI script automates adding keyword tags ("Past paper," "Exam paper," and "Practice paper") to modules in the SLS Community Gallery if the module title contains the keyword "SBA" and a numeric identifier formatted as `(XXXX)`.

## Usage

Execute the script using:

```shell
tagui cgkeyword.tag SLS_CG_2024_11NovExamPApersURL.csv -h -l
older command
tagui cgkeyword.tag SLS_CG_2024_11.csv
```

- Ensure that `SLS_CG_2024_11.csv` or `SLS_CG_2024_11NovExamPApersURL` contains URLs to Community Gallery modules.

## Requirements

- TagUI installed
- Access to SLS (Singapore Student Learning Space)
- Valid login credentials

## Script Functionality

### Step 1: Login
- Opens the SLS login page.
- Automatically logs in using predefined credentials.

### Step 2: Check Module Title
- Reads the module title.
- Checks for the existence of a numeric identifier `(XXXX)`.
- Confirms the presence of keyword "SBA".

### Step 3: Tagging Keywords
- If both conditions are met, adds the following keywords to the module:
  - Past paper
  - Exam paper
  - Practice paper
- Saves changes and confirms completion.

## Customization

Replace login credentials (`MOE-XXXXXXH` and password) and CSV file with your own to match your environment and data.

## Author
- Lawrence Wee - [lawrence_wee@moe.gov.sg]

## Date
- 2025-03-13


