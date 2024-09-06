# Compose Email Automation using TagUI

This TagUI script automates the process of composing and saving draft emails in the WOG Webmail system (https://webmail.sgmail.sgnet.gov.sg/owa). The script reads email data (recipient, CC, BCC, subject, and body) from a CSV file (`dataEmail.csv`), composes the email, and saves it as a draft. The email body is populated using a template stored in a `.docx` file.

## Prerequisites

1. **TagUI**
   - Ensure that TagUI is installed and functioning on your system.

2. **Data File (dataEmail.csv)**
   - This file should contain the email details with the following columns:
     - **To**: Recipient email addresses.
     - **Cc**: CC email addresses.
     - **Bcc**: BCC email addresses.
     - **Subject**: Subject line for the email.

3. **Word Document (tagui_Email_to_SSEF_TCs.docx)**
   - This `.docx` file contains the body of the email that will be inserted into the message body field.

## Usage

To run the automation:

```bash
tagui compose_mailwog.tag dataEmail.csv -t
