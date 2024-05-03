//INSTALLATION
// https://tagui.readthedocs.io/en/latest/setup.html
// to run file type in command line
// cd /Users/lookang/Desktop/tagui/flows/cpddPhyiscsLessonTag/ 
// tagui moelibrarycrawl.tag

//Enter into SLS login page
https://vle.learning.moe.edu.sg/login


//live

wait 3
click //button[normalize-space()='Login With SLS']
click //button[normalize-space()='Login']

// Navigate to the resource management page
// A level Physics example
https://vle.learning.moe.edu.sg/manage-resource?resource=LESSON&location=MOE&ownerGroups=1126,1121,1174,1163&status=ALL&subjects=476,611,906
//A Biology
//https://vle.learning.moe.edu.sg/manage-resource?resource=LESSON&location=MOE&ownerGroups=1126,1121,1174,1163&status=ALL&subjects=391,506,631
echo "search for the concept maps you wish to extract out using RPA and type done on the terminal command line when ready to continue"
live 




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

//filename, change this by yourself if need
filename = "crawldatabasePhysics"

// WRITING TO FILE , Create if missing, replace if presen
dump i, title, type, subject, level, modifiedBy, status, ownerGroup, link, conceptMaps to `filename`.csv
//live
// Define table counter
tableCnt = 0
// Define row counter
rowCnt = 1

// loop to skip the specified number of tables
for i from 1 to tableCnt
    click //button[@aria-label="Next page"]

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
        read //*[@id="main-content"]/div/div/section/div/div[2]/div[2]/div/div[1]/table/tbody/tr[`rowCnt`]/td[6]/div/span to modifiedBy
        read //*[@id="main-content"]/div/div/section/div/div[2]/div[2]/div/div[1]/table/tbody/tr[`rowCnt`]/td[7]/div/span to status
        read //*[@id="main-content"]/div/div/section/div/div[2]/div[2]/div/div[1]/table/tbody/tr[`rowCnt`]/td[8]/div/span[1] to ownerGroup
        read //*[@id="main-content"]/div/div/section/div/div[2]/div[2]/div/div[1]/table/tbody/tr[`rowCnt`]/td[9]/div/ul/li/span to conceptMaps

        // Click to open the lesson
        click //*[@id="main-content"]/div/div/section/div/div[2]/div[2]/div/div[1]/table/tbody/tr[`rowCnt`]/td[1]/div/div/a
        popup lesson/view/
        {
        wait 1 
        js link = url()
        // read the title
        //read output-text to title
        //echo `title`
        echo `link`
        dom window.close()
        }



        // Store pending lessons data
        js pending.push([i, title, type, subject, level, modifiedBy, status, ownerGroup, link, conceptMaps])

        // Write data to CSV file
        write `csv_row(pending[i - 1])` to `filename`.csv

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
