
# SLS Login and Lesson Data Extraction with TagUI

## Description:

This script leverages TagUI to automate the process of logging into the SLS portal [SLS Login Page](https://vle.learning.moe.edu.sg/login) and extracting data on available lessons. It retrieves details such as title, type, subject, level, modified by, status, owner group, link, and concept maps.

## Prerequisites:

- TagUI installed: Refer to the official TagUI documentation for installation instructions: [TagUI Setup](https://tagui.readthedocs.io/en/latest/setup.html)
- Basic understanding of TagUI scripting syntax.

## Script Breakdown:

1. **Login to SLS (password protected, manual intervention required):**
   - Navigates to the SLS login page [SLS Login Page](https://vle.learning.moe.edu.sg/login).
   - Clicks on the button labeled "Login With SLS".
   Note: This script requires manual intervention to log in. Consider adding logic to interact with login form elements if possible (security considerations apply).

2. **Navigate to Resource Management Page:**
   - Opens the lesson resource management page with specific filters using the URL command.

3. **Get Total Number of Lessons:**
   - Checks if the pagination element is present using `exist`.
   - If present, extracts the total number of lessons from the pagination text using `read` and splits it based on "of".
   - Prints the total number of lessons found using `echo`.

4. **Loop Through Lessons:**
   - Iterates through each lesson row in the table (up to 20 lessons per page) using a `for` loop.
   - If the row is present (check using `exist`), extracts data for each column:
     - Title (read to specific element)
     - Type (read to specific element)
     - Subject (read to specific element)
     - Level (read to specific element)
     - Modified By (read to specific element)
     - Status (read to specific element)
     - Owner Group (read to specific element)
     - Link (opens the lesson in a popup window and extracts link using JavaScript)
     - Concept Maps (read to specific element)
   - Writes the extracted data to a CSV file (`crawldatabase2.csv`) using write `csv_row(pending[i - 1])` to crawldatabase.csv
   - If there are 20 lessons on a page, clicks the "Next page" button to proceed.

5. Educational and Productivity Purposes
   - the script does NOT work if there is no creditials to login to SLS and rights to edit the lessons. The script are meant to help others increase their productivity especially those still manually editing or tagging their SLS lessons.
   
This README provides a detailed explanation of the script's functionality, prerequisites, and breakdown of the script's execution steps. Adjustments can be made as needed to further clarify or expand upon any aspect of the script or its usage.
