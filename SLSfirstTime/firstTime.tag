// The following script is meant to be executed via the command line.
// To run it, use the following command:
// tagui firstTime.tag
// Its purpose is to enable the browser to store login IDs and passwords for future use.

// Step 1: Navigate to the SLS login page
https://vle.learning.moe.edu.sg/login

// Step 2: Prompt user for choice
// ask_result = 1
ask 1 for SLS or 2 for MIMS login

// Step 3: Prompt user to enter login ID and password, and save the credentials
ask Please enter one of your login ID and password, then press 'Enter'. When prompted to save the passwords, click 'YES' to allow the browser to use your login credentials in future sessions. Click "OK" to proceed.

// Continue script execution
live
// LIVE MODE - type done to quit