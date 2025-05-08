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

classAddTeachers2.tag – Automate Adding Teachers to SLS Class Groups
This TagUI script automates the process of logging into the Singapore Student Learning Space (SLS) and adding teachers to a specified class group using data from a CSV file.

📌 Features
Logs into SLS via the "Login With SLS" flow.

Navigates to the class group management page.

Adds teachers to a class group using details from a provided data.csv.

Designed to run in batch mode for multiple iterations.

🗂️ Files Required
classAddTeachers2.tag — The automation script.

data.csv — The input data file containing teacher information (e.g., email addresses, class group URLs).

📋 Usage
Run the script using TagUI command line:

bash
Copy
Edit
tagui classAddTeachers2.tag data.csv
Ensure both classAddTeachers2.tag and data.csv are in the same directory.

📑 Structure of data.csv
csv
Copy
Edit
email,class_group_url
teacher1@moe.edu.sg,https://vle.learning.moe.edu.sg/studentgroup/...
teacher2@moe.edu.sg,https://vle.learning.moe.edu.sg/studentgroup/...
...
Adjust the columns based on how the script processes inputs.

🔐 Authentication Flow
The script performs the following during login:

Opens the SLS login page.

Clicks the "Login With SLS" button.

Confirms login and redirects to the Class Group Management interface.

🛠️ Customization
Modify the class group URL in the script to dynamically reflect different class groups.

Adjust XPath or button identifiers if SLS UI changes.

⚠️ Notes
Ensure proper permissions to access and edit class groups in SLS.

TagUI must be installed on your machine. Installation guide
