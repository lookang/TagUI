//INSTALLATION
// https://tagui.readthedocs.io/en/latest/setup.html

//Enter into SLS login page
https://vle.learning.moe.edu.sg/login

echo "Login yourself as requested to overcome slow WOG. Either SLS or MIMS is fine."
//live

wait 3
click //button[normalize-space()='Login With SLS']
click //button[normalize-space()='Login']

// Navigate to the resource management page
https://vle.learning.moe.edu.sg/manage-resource?resource=LESSON&location=MOE&ownerGroups=1126,1121,1174,1163&status=ALL&subjects=476,611,906



// Get the total number of lessons
if present("//div[@class='v-data-table-footer__info']//div")
    read //div[@class='v-data-table-footer__info']//div to pagination
    js total = parseInt(pagination.split("of")[1].trim());
    echo "There are " + total + " number of lessons."

// Prompt the user to check the pending review list
//echo "To allow admin to check the pending review list, type 'done' to exit and continue flow."
//live

// Get the total number of rows after reviews
read //div[@class='v-data-table-footer__info']//div to pagination
js total = parseInt(pagination.split("of")[1].trim());
//echo "After reviews, there are " + total + " number of lessons."

// WRITING TO FILE , Create if missing, replace if presen
dump i, title, type, subject, level, modifiedBy, status, ownerGroup, link, conceptMaps to crawldatabase2.csv
live
// Define table counter
tableCnt = 0
rowCnt = 1
// Array to store pending lessons
pending = []
link = ""
// Loop through the table
for i from 1 to total
    // Check if the row is present
    if (exist('//*[@id="main-content"]/div/div/section/div/div[2]/div[2]/div/div[1]/table/tbody/tr[`rowCnt`]/td[1]/div/div/span/span'))
        // Read data from the table
        read //*[@id="main-content"]/div/div/section/div/div[2]/div[2]/div/div[1]/table/tbody/tr[`rowCnt`]/td[1]/div/div/span/span to title
        read //*[@id="main-content"]/div/div/section/div/div[2]/div[2]/div/div[1]/table/tbody/tr[`rowCnt`]/td[2]/div/span to type
        read //*[@id="main-content"]/div/div/section/div/div[2]/div[2]/div/div[1]/table/tbody/tr[`rowCnt`]/td[3]/div/div/div/span to subject
        read //*[@id="main-content"]/div/div/section/div/div[2]/div[2]/div/div[1]/table/tbody/tr[`rowCnt`]/td[4]/div/span to level
        read //*[@id="main-content"]/div/div/section/div/div[2]/div[2]/div/div[1]/table/tbody/tr[1]/td[5]/div/time to modifiedBy
        read //*[@id="main-content"]/div/div/section/div/div[2]/div[2]/div/div[1]/table/tbody/tr[1]/td[7]/div/span to status
        read //*[@id="main-content"]/div/div/section/div/div[2]/div[2]/div/div[1]/table/tbody/tr[`rowCnt`]/td[8]/div/span[1] to ownerGroup
        read //*[@id="main-content"]/div/div/section/div/div[2]/div[2]/div/div[1]/table/tbody/tr[1]/td[9]/div/ul to conceptMaps

        // Click to open the lesson
        click //*[@id="main-content"]/div/div/section/div/div[2]/div[2]/div/div[1]/table/tbody/tr[`rowCnt`]/td[1]/div/div/a
        popup lesson/view/
        {
        wait 1 
        js link = url()
        // read the title
        read output-text to title
        echo `title`
        echo `link`
        dom window.close()
        }



        // Store pending lessons data
        js pending.push([i, title, type, subject, level, modifiedBy, status, ownerGroup, link, conceptMaps])

        // Write data to CSV file
        write `csv_row(pending[i - 1])` to crawldatabase.csv

        // Increment row counter
        js rowCnt++
        if (rowCnt == 21)
        {
            click //button[@aria-label="Next page"]
            js tableCnt++; // maybe TagUI code has no ++ so use js
            rowCnt = 1
            wait 2
        }
    else
        break
