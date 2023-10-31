import rpa as r

# [RPA][ERROR] - use init() before using url()
r.init()

# Navigate to the SLS login page
r.url('https://vle.learning.moe.edu.sg/login')

# Prompt user for choice
ask_result = r.ask('1 for SLS or 2 for MIMS login')

# Prompt user to enter login ID and password, and save the credentials
r.ask("Please enter one of your login ID and password, then press 'Enter'. When prompted to save the passwords, click 'YES' to allow the browser to use your login credentials in future sessions. Click 'OK' to proceed.")

# Continue script execution
# AttributeError: module 'rpa' has no attribute 'live'
# r.live()
# replace live with wait 600 seconds
r.wait(600)