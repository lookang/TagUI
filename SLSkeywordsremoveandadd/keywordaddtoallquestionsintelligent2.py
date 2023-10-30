
# to run type
# python keywordaddtoallquestionsintelligent2.py
import rpa as r # import tagui python library
import pandas as pd  # Import the Pandas library
# import csv # unused?


# Navigate to the SLS login page
r.init(visual_automation=False)
r.url("https://vle.learning.moe.edu.sg/login")
r.wait(3)

# Ask for SLS (1) or MIMS (2) login
ask_result = 1  # Set your choice here
r.echo(ask_result)

if ask_result == 1:
    if r.present('//button[normalize-space()="Login With SLS"]'):
        r.click('//button[normalize-space()="Login With SLS"]')
    if r.present("//button[normalize-space()='Login']"):
        r.click("//button[normalize-space()='Login']")
elif ask_result == 2:
    if r.present("//button[normalize-space()='Login With MIMS']"):
        r.click("//button[normalize-space()='Login With MIMS']")
        r.wait(3)
        r.click(r.read('(//span[@id="loginButton2"])[1]'))


# Read the CSV file
df = pd.read_csv('url.csv')

# Iterate over each row in the DataFrame
for index, row in df.iterrows():
    p3 = row['p3']  # replace with your actual column name
    p4 = row['p4']
    p5 = row['p5']
    p6 = row['p6']
    p7 = row['p7']
    p8 = row['p8']
    p9 = row['p9']
    p10 = row['p10']
    p11 = row['p11']
    add1 = row['add1']
    add2 = row['add2']
    print(f'add1 is {add1}')
    print(f'add2 is {add2}')

    # Check if p3 contains "mrv"
    if "mrv" in p3:
        indexPosition = 47
    else:
        indexPosition = 43

    temp2 = p3[:indexPosition] + "/admin" + p3[indexPosition:]
    # Log the value of temp2
    print(f'Value of temp2: {temp2}')

    # Remove the "https://" from temp2 to get temp
    temp = temp2[8:]
    # Log the value of temp
    print(f'Value of temp2: {temp2}')

    # Access the URL
    r.wait(3)
    r.url(temp2)
    r.wait(3)

    # Check if the 'Unpublish' button is present
    print(f'Check if the "Unpublish" button is present')
    if r.present("(//*[name()='svg'][@name='Unpublish32'])"):
        # Click the 'Unpublish' button
        r.click("(//*[name()='svg'][@name='Unpublish32'])")

        # Click the 'OK' button
        r.click("//span[normalize-space()='OK']")

    # Click the first 'Open' link
    r.click("(//a[contains(text(),'Open')])[1]")

    r.popup("lesson/view/")
    # Cheat code to go edit mode
    temp3 = temp.replace("view","edit")
    r.url('https://' + temp3)
    print(f'Value of temp3: {temp3}')
    r.wait(5)

    # Determine activity count
    numberofA = r.count("//div[@class='activity-label editor-mode']")
    print('numberofA is', numberofA)

    for m in range(1, numberofA + 1):
        r.click("(//div[@class='activity-label editor-mode'])[" + str(m) + "]")
        print(r.read('(//div[@class="activity-label editor-mode"])[' + str(m) + ']'))
        r.wait(3)

        # Determine settings count
        numberofS = r.count("(//*[name()='svg'][@name='Settings24'])")
        print('numberofS is', numberofS)

        # Skip first Setting24 as it is the lesson
        start = 2

        for k in range(start, numberofS + 1):
            r.wait(3)
            if r.present("(//*[name()='svg'][@name='Settings24'])[" + str(k) + "]"):
                r.click("(//*[name()='svg'][@name='Settings24'])[" + str(k) + "]")
                r.wait(1)
                if r.present("//input[@placeholder='Add descriptive tags for others to find it']"):
                    # Determine existing keywordtag count
                    numberofT = r.count("(//span[@title='Clear filter']//span[contains(text(),'')])")
                    for i in range(1, numberofT + 1):
                        # Reverse the order of clicks to avoid deleting count of keywordtag
                        j = numberofT + 1 - i
                        element = r.read("(//span[@title='Clear filter']//span[contains(text(),'')])[" + str(j) + "]")
                        print(j, 'is', element)

                        # Hoping JavaScript can lower the case to be compared.
                        element = element.lower()

                        # Appears to be case sensitive so need more or statements appears to have a limit of 4 "or"
                        if p4 in element or p5 in element or p6 in element or p7 in element:
                            print('found j =', j)
                            r.click("(//button[@aria-label='Clear filter'])[" + str(j) + "]")
                        if p8 in element or p9 in element or p10 in element or p11 in element:
                            print('found2 j =', j)
                            r.click("(//button[@aria-label='Clear filter'])[" + str(j) + "]")

                    # Add blindly for modular and ease of scalability
                    r.type('bx--text-input', add1)
                    r.click("(//*[name()='svg'][@name='Save24'])[1]")
                    r.type('bx--text-input', add2)
                    # Button is not visible yet, need to wait
                    r.wait(2)
                    r.click("(//*[name()='svg'][@name='Save24'])[1]")

                # If not found
                r.click("(//*[name()='svg'][@name='Close24'])")

        # Active the publish button
        r.url('https://' + temp)
        r.click('Approve32')
        r.click("//span[normalize-space()='OK']")

        # Close tab
        r.dom('window.close()')
        r.popup()


# r.close()