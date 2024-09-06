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

compose_mailwog.tag: The TagUI script file that contains the automation logic.
dataEmail.csv: The input file containing email details.
-t: Specifies running in text mode.
## How the Script Works
Load Data

The script reads the recipient details (To, Cc, Bcc, Subject) from the CSV file.
Navigate to WOG Webmail

It opens the WOG Webmail system in the browser at https://webmail.sgmail.sgnet.gov.sg/owa.
Handle Pop-ups

If a pop-up with an "OK" button appears, the script clicks it to proceed.
Compose New Email

Clicks the "Write a new message" button.
Fills in the To, Cc, Bcc, and Subject fields with the information from the CSV file.
Load Email Body

The body of the email is fetched from the file tagui_Email_to_SSEF_TCs.docx and the content is inserted into the message body.
Save Draft

The script saves the composed email as a draft by selecting the "Save draft" option.
Optional - Schedule Send

There is an option to schedule the email for sending the next morning, which is currently commented out in the script.
