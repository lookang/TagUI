# `deleteByCSV.tag` Automation Script

This `deleteByCSV.tag` script automates the deletion of lessons in the SLS (Singapore Learning Space) platform based on a provided CSV file. It uses the TagUI RPA tool for automating browser interactions.

---

## Overview

### Features
- Reads lesson data from a CSV file.
- Logs into the SLS platform and navigates to lesson management URLs.
- Checks and interacts with elements dynamically to delete specified lessons.
- Handles different states of the lessons (published, draft, etc.).
- Provides real-time feedback during the automation process.

---

## Files Included
1. **`deleteByCSV.tag`**  
   The main TagUI script file that runs the automation process.
   
2. **`scienceNT2024_LSSSLSlessonstodelete.csv`**  
   The input CSV file containing lesson details for deletion.

---

## Prerequisites
- **TagUI Installation**: Ensure TagUI is installed on your system. [Download TagUI](https://tagui.readthedocs.io/en/latest/setup.html)
- **Access to SLS Platform**: User credentials for the SLS platform with permissions to manage and delete lessons.
- **CSV Format**: The CSV file should have the following columns:
  - `LessonAdminURL`: Full admin URL for the lesson.
  - `LessonTitle`: Title of the lesson for logging purposes.

---

## Script Workflow

1. **Initialization**:
   - Start by reading the `LessonAdminURL` and `LessonTitle` fields from the CSV file.
   - Log the current iteration and lesson details for traceability.

2. **Login to SLS**:
   - Navigate to the SLS login page: `https://vle.learning.moe.edu.sg/login`.
   - Wait for 5 seconds to allow the page to load.
   - Perform login steps by clicking the "Login With SLS" button and entering user credentials.

3. **Navigate to Lesson Management**:
   - Extract the editable portion of the URL using `substring` and navigate to the lesson's admin page.
   - Read the title of the lesson for verification.

4. **Lesson State Handling**:
   - If the lesson is unpublished (denoted by the "Pen32" icon), move it to the draft state.

5. **Delete Lesson**:
   - Access the delete option through the "Kebab" menu (three dots).
   - Confirm the deletion action.

---

## How to Use

1. **Update CSV File**:
   - Prepare a CSV file (`scienceNT2024_LSSSLSlessonstodelete.csv`) with the necessary lesson URLs and titles.

2. **Run the Script**:
   - Execute the script using TagUI:
     ```bash
     tagui deleteByCSV.tag
     ```

3. **Monitor the Logs**:
   - The script logs real-time progress, including:
     - The lesson title and admin URL being processed.
     - Any errors or exceptions during the process.

---

## Notes

- **Login Credentials**:
  - Replace placeholders `[clear]MOE-XXXXXX` and `[clear]PASSWORD` in the script with your actual SLS credentials.

- **Error Handling**:
  - Ensure the script is tested on a staging environment before running on live data.
  - If the "Pen32" or "Kebab24" elements are not found, the script logs the issue and skips to the next iteration.

- **Script Modifications**:
  - Update the XPath selectors (e.g., `//button[normalize-space()='Login']`) if SLS platform UI changes.

---

## Example CSV Format

```csv
LessonAdminURL,LessonTitle
https://vle.learning.moe.edu.sg/admin/lesson/1,Lesson 1
https://vle.learning.moe.edu.sg/admin/lesson/2,Lesson 2
```

---

## License

This script is intended for internal use within the SLS ecosystem. Ensure compliance with organizational guidelines and data security policies.
