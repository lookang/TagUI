https://www.moe.gov.sg/private-education/private-schools

//manually change
total = 858

//variables
tableCnt = 1
rowCnt = 1
pending = []

// i is variable  
for i from 1 to (total)
    echo `rowCnt`
    // initialise variables in case not found as strings
    fax = ""
    email = ""
    // trying to break out if total is not found 
    // if title exists assumes always first item
    if (exist('/html/body/main/div[2]/div/div/div/div/div/div[`rowCnt`]/p')) 
        // if title exists
        read /html/body/main/div[2]/div/div/div/div/div/div[`rowCnt`]/p to title
        //echo `title`
    // if address exists
    if (exist('/html/body/main/div[2]/div/div/div/div/div/div[`rowCnt`]/div/div[1]/a')) 
        read /html/body/main/div[2]/div/div/div/div/div/div[`rowCnt`]/div/div[1]/a to address
        //echo `address`
    // if phone exists
    if (exist('/html/body/main/div[2]/div/div/div/div/div/div[`rowCnt`]/div/div[2] ')) 
        read /html/body/main/div[2]/div/div/div/div/div/div[`rowCnt`]/div/div[2] to phone
        //echo `phone`
        // to handle missing emails from table
    // if fax or email is next/exists
    if (exist('/html/body/main/div[2]/div/div/div/div/div/div[`rowCnt`]/div/div[3] '))
        read /html/body/main/div[2]/div/div/div/div/div/div[`rowCnt`]/div/div[3]/i/@class to icon_class
        echo `icon_class`
        if (icon_class.indexOf("icon-printer") !== -1)
            // fax exists
            //echo fax exists
            read /html/body/main/div[2]/div/div/div/div/div/div[`rowCnt`]/div/div[3] to fax
            //echo `fax` + line 51
        else if (icon_class.indexOf("icon-email") !== -1)
            // email exists
            //echo email exists
            read /html/body/main/div[2]/div/div/div/div/div/div[`rowCnt`]/div/div[3]/a to email
            //echo `email`
    // fax or email again , data on website can be arranged that way
    if (exist('/html/body/main/div[2]/div/div/div/div/div/div[`rowCnt`]/div/div[4] '))
        read /html/body/main/div[2]/div/div/div/div/div/div[`rowCnt`]/div/div[4]/i/@class to icon_class
        //echo `icon_class`
        if (icon_class.indexOf("icon-printer") !== -1)
            // fax exists
            //echo fax exists
            read /html/body/main/div[2]/div/div/div/div/div/div[`rowCnt`]/div/div[4]/i to fax
            //echo `fax`
        else if (icon_class.indexOf("icon-email") !== -1)
            // email exists
            //echo email exists
            read /html/body/main/div[2]/div/div/div/div/div/div[`rowCnt`]/div/div[4]/a to email
            //echo `email`
    else
        // do ntg see if can be faster 

    js pending.push([rowCnt*tableCnt, title, address, phone, fax, email])
    // WRITING TO FILE IMMEDIATELY TO AVOID LOSS
    write `csv_row(pending[i - 1])` to moereview_list.csv
    js console.log(pending[i-1])

    js rowCnt++;
    if (rowCnt == 21)
        {
        click icon-arrow-right
        js tableCnt++; // maybe TagUI code has no ++ so use js
        rowCnt = 1
        wait 2
        }
   