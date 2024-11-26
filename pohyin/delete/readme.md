SLS TagUI Script README
This repository contains a TagUI automation script designed to interact with the Singapore Student Learning Space (SLS) platform for managing draft lessons. The script automates login and lesson management, including identifying drafts and deleting selected resources.

Features
Automates login to the SLS platform.
Navigates to the draft resources management page.
Deletes draft lessons based on specified filters.
Handles repetitive tasks for up to a predefined number of iterations.
Prerequisites
TagUI Installation: Ensure you have TagUI installed on your machine. Install TagUI.
Login Credentials: Replace placeholders in the script (MOE-XXXXXX and PASSWORD) with your SLS login details.
Supported Browser: Make sure your browser is compatible with TagUI and is set up for automation.
Usage Instructions
Clone the Repository:

bash
Copy code
git clone https://github.com/your-repo/sls-tagui-script.git
cd sls-tagui-script
Modify the Script:

Open the script file and update the following:
Replace MOE-XXXXXX with your SLS username.
Replace PASSWORD with your SLS password.
Run the Script: Execute the script using TagUI:

bash
Copy code
tagui sls-script.tag
Process Flow:

The script will navigate to the SLS login page.
Log in using the provided credentials.
Access the draft lessons page and process drafts up to the specified iteration count (end variable).
Code Overview
tagui
Copy code
// Navigate to the SLS login page
https://vle.learning.moe.edu.sg/login
wait 5

// Login process
click //button[normalize-space()='Login With SLS']
type bx--text-input as [clear]MOE-XXXXXX
click //input[@placeholder='SLS Password'] 
type //input[@placeholder='SLS Password'] as [clear]PASSWORD
click //button[normalize-space()='Login']

// Iterative process for handling drafts
end = 20
for i from 1 to end
    https://vle.learning.moe.edu.sg/manage-resource?resource=LESSON&location=MOE&ownerGroups=1126,1121,1174,1163&status=DRAFT&subjects=12790

    click (//a[@tag='component'][normalize-space()='Open'])[1]

    popup cover
        {
        click //button[@aria-controls='lesson-submenu']//*[name()='svg']
        click //li[@class='delete moe-library']//a[@class='cv-link bx--link']
        click OK
        dom window.close()
        }
Notes
Iteration Limit: The script processes up to 20 drafts (end = 20). Modify this variable as needed.
Error Handling: The script does not include comprehensive error handling. Ensure a stable connection and test on a small dataset before full execution.
Sensitive Data: Avoid sharing your script publicly with credentials.
Troubleshooting
Login Issues:

Ensure the correct username and password are entered.
Confirm SLS is accessible and not undergoing maintenance.
Script Errors:

Check browser compatibility and configurations for TagUI.
Validate that all XPath selectors used in the script align with the current SLS UI.
Adjust Iterations:

Modify the end variable to control the number of drafts processed.
