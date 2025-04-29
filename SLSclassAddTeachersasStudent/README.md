# TagUI Script: Add Teachers as Students

This script automates the process of adding teachers as students to a specific class group in the MOE Learning VLE.

## Prerequisites

- TagUI installed.
- A `data.csv` file in the same directory as the script, containing a column named `Email` with the email addresses of the teachers to be added.

## How to Run

1. Open your command line or terminal.
2. Navigate to the directory containing the script and the `data.csv` file (`c:\rpa\tagui\flows\crmwPD`).
3. Run the following command:

   ```bash
   tagui classAddTeachersasStudents.tag data.csv
   ```

This command will execute the `classAddTeachersasStudents.tag` script, using the email addresses provided in the `data.csv` file.