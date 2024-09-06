Compose Email Automation using TagUI
This TagUI script is designed to automate the process of composing and saving draft emails in WOG Webmail (webmail.sgmail.sgnet.gov.sg). The script reads the email data (recipient, CC, BCC, subject, and body) from a CSV file (dataEmail.csv), formats the email, and saves it as a draft. The email body is populated using a template stored in a .docx file.

Prerequisites
TagUI: Ensure that TagUI is installed and working on your system.
Download and installation instructions can be found at TagUI GitHub.
Data File (dataEmail.csv): This file contains the details for email composition such as:
To: Recipient email addresses.
Cc: CC email addresses.
Bcc: BCC email addresses.
Subject: Subject line for the email.
Word Document (tagui_Email_to_SSEF_TCs.docx): This Word document contains the body of the email, which is inserted into the email body during the automation process.
Command
To run this automation:

bash
Copy code
// tagui compose_mailwog.tag dataEmail.csv -t
This command uses the compose_mailwog.tag script and dataEmail.csv as the input for the automation. The -t option enables text mode.

Script Overview
Steps
Load Data: The script starts by loading the email details from the CSV file (To, Cc, Bcc, Subject).

Access Webmail: The script navigates to the WOG webmail site (webmail.sgmail.sgnet.gov.sg) and prepares the page for composing a new email.

Handle Webmail Pop-ups: If a pop-up (such as an "OK" button) appears on the page, the script automatically clicks it to proceed.

Compose New Email:

It clicks the "Write a new message" button to start composing a new email.
The script populates the To, Cc, and Bcc fields using the data loaded from the CSV file.
It sets the subject of the email using the subject field from the CSV file.
Load Email Body:

The body of the email is loaded from the file tagui_Email_to_SSEF_TCs.docx.
The script then pastes the body content into the email message body section.
Save Draft:

After composing the email, the script clicks on "More actions" and selects "Save draft" to save the composed email as a draft.
Send Option (Currently commented):

The script includes an option to schedule the email for sending the next morning, but this step is currently commented out (//click Send).
Example CSV Format
Below is an example of how the dataEmail.csv file should be structured:

i	to	cc	bcc	subject
1	recipient1@xyz.com	cc1@xyz.com	bcc1@xyz.com	Important Notice: Meeting Info
2	recipient2@xyz.com	cc2@xyz.com	bcc2@xyz.com	Action Required: Review Document
Key Components
Dynamic Variables: The script dynamically injects variables such as to, cc, bcc, and subject into the respective fields.
Wait Times: Several wait commands are used to handle loading delays in the webmail interface, especially given that WOG Webmail performance might slow down during heavy use.
Error Handling: Checks for pop-ups or alerts such as OK buttons are included to ensure the script continues even if such interruptions occur.
Notes
Scheduling Emails: The script includes an option to schedule the email to be sent the next morning, but it is currently disabled. You can enable it by uncommenting the relevant lines (//click Send).

File Upload (Optional): If you wish to attach a document (e.g., Merged_Email_to_SSEF_TCs.docx), additional code for uploading attachments is included but commented out. You can modify this to include attachments.

Adaptation: This script can be adapted to suit different email platforms or different document structures.

Troubleshooting
If the webmail interface changes, you may need to update the XPaths used in the script to select buttons and input fields.
Ensure proper file paths for the .docx file and other files used in the automation.
If delays are encountered due to slow loading times, adjust the wait times accordingly.
