# Posting2 Automate Social Posting

This script automates interactions with the SLS (Student Learning Space) platform for updating lesson titles and accessing specific URLs. The script uses TagUI, a free and open-source RPA tool by AI Singapore, to perform the necessary actions.

## Prerequisites

- Install [TagUI](https://github.com/kelaberetiv/TagUI).
- Prepare the `scienceNT2024.csv` file with the following columns:
  - `LessonAdminURL`
  - `LessonTitle`
- Ensure you have SLS credentials for login.

## Features

### 1. Login Automation
- Navigates to the SLS login page and logs in using specified credentials.

### 2. Lesson Data Access
- Fetches and processes lesson information from the provided `scienceNT2024.csv` file.

### 3. Title Update
- Updates lesson titles to include a reference to the 2014 USS NT syllabus.

### 4. Dynamic Navigation
- Constructs URLs dynamically for accessing lesson administration pages.

## Workflow

### 1. Initialization
- The script initializes variables like `LessonAdminURL` and `LessonTitle` from the CSV file.
- Iterates over each row in the file.

### 2. Login
- Opens the SLS login page.
- Waits for the login page to load and performs login actions.

### 3. Lesson Data Processing
- Extracts and processes the `LessonAdminURL` to dynamically construct a URL.
- Reads the lesson title from the page.

### 4. Title Update
- Replaces parts of the title with the phrase "[For 2014 USS NT syllabus]".
- Updates the title and approves the changes.

### 5. Cleanup
- Closes any open popups and ends the session.

## Script Details

### Variables

- **`LessonAdminURL`**: Extracted from the CSV file, used to navigate to the admin page.
- **`LessonTitle`**: The lesson title to be updated.
- **`fulleditableURLsubstring`**: Used for constructing dynamic URLs.
- **`updatedText`**: Stores the updated lesson title.

### Key Actions

#### Navigate to URLs
```
https://`fulleditableURLsubstring`
```

#### Read Title
```
read (//div[@class='output-text'])[1] to title
```

#### Update Title
```
updatedText = LessonTitle.replace(/\[.*?\]/, "[For 2014 USS NT syllabus]");
type //input[@class='bx--text-input'] as [clear]`updatedText`
```

## Usage

1. Place the `retag.tag` script and the `scienceNT2024.csv` file in the same directory.
2. Run the script using the following command:
   ```
   tagui retag.tag scienceNT2024.csv
   ```
3. Monitor the script execution and confirm any prompts if required.

## Troubleshooting

### Login Issues
- Ensure the correct SLS credentials are entered.
- Verify the login page URL is accessible.

### Script Errors
- Check if the `scienceNT2024.csv` file is correctly formatted.
- Review the TagUI logs for specific errors.

## Notes

- This script is customized for the NT syllabus for 2024. Modify as needed for other syllabi or requirements.
- Ensure compliance with any applicable data privacy regulations when using this script.

## License

CC-BY

## Disclaimer
This script is provided as-is without warranty. Use it at your own risk.


