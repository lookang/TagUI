
# SLSfirstTime

This repository contains scripts for saving login credentials. The scripts are available in both TagUI and TagUI-Python.

## TagUI Script

The TagUI script is designed to be executed from the command line. Its purpose is to enable the browser to store login IDs and passwords for future use.

To run the script, use the following command:

```bash
tagui firstTime.tag
```

The script will navigate to the SLS login page, prompt you for your choice of login, ask you to enter your login ID and password, and then save these credentials for future use.

## TagUI-Python Script

The TagUI-Python script serves the same purpose as the TagUI script but is written in Python.

Before running the script, make sure to import the `rpa` module as `r`:

```python
import rpa as r
```

To run the script, initialize RPA, navigate to the SLS login page, prompt for user choice, ask for login ID and password, and then save these credentials:

```python
r.init()
r.url('https://vle.learning.moe.edu.sg/login')
ask_result = r.ask('1 for SLS or 2 for MIMS login')
r.ask("Please enter one of your login ID and password, then press 'Enter'. When prompted to save the passwords, click 'YES' to allow the browser to use your login credentials in future sessions. Click 'OK' to proceed.")
r.wait(600)
```

Please note that these scripts are for educational and illustrative purposes. Use them responsibly and in compliance with the website's terms and policies.
```
