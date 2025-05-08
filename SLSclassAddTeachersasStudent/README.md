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

# 📘 SLS Class Group Teacher Adder – `classAddTeachers2.tag`

This [TagUI](https://tagui.readthedocs.io/) script automates the process of logging into the **Singapore Student Learning Space (SLS)** and adding teachers to specific class groups using data from a CSV file.

---

## ✅ Features

- 🔐 Automated login via **"Login with SLS"** button
- 📂 Navigates directly to the class group management interface
- 👩‍🏫 Adds teachers to class groups using entries from a data file
- 🔁 Supports batch processing with multiple entries in `data.csv`

---

## 📁 Required Files

| File Name               | Purpose                                   |
|------------------------|-------------------------------------------|
| `classAddTeachers2.tag`| TagUI script to perform the automation    |
| `data.csv`             | CSV file containing teacher and group info|

---

## ▶️ How to Run

Open your terminal or command prompt and run:

```bash
tagui classAddTeachers2.tag data.csv

🧾 data.csv Format
email,class_group_url
teacher1@moe.edu.sg,https://vle.learning.moe.edu.sg/studentgroup/abc123
teacher2@moe.edu.sg,https://vle.learning.moe.edu.sg/studentgroup/xyz456

## 🔐 Login Flow
Open SLS login page.

Click "Login with SLS".

Authenticate (if needed).

Redirect to the Class Group Management Page.

## 🛠️ Tips for Customization
✏️ Update the target URL if your class group changes dynamically.

🔍 Review XPath selectors if the SLS interface updates.

##📌 Prerequisites
TagUI installed

Valid access permissions for the SLS class groups



