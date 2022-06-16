
//https://tagui.readthedocs.io/en/latest/reference.html


//visit URL
https://vle.learning.moe.edu.sg/mrv/community-gallery/admin

//assume login needed
//if present('.button.login')
wait 1
if present('//button[@type="button"]')
    click .button.login
    wait 5

    code = ""
    https://mail.google.com/mail/u/0/#inbox"
    // Click Sign in 
    wait 5
    // click the first email by notifications@sls.ufinity.com in the table
    click //*[@email="notifications@sls.ufinity.com"]/ancestor-or-self::tr
    read //div[7]/div[3]/div/div[2]/div[1]/div[2]/div/div/div/div/div[2]/div/div[1]/div/div[2]/div/table/tr/td[1]/div[2]/div[2]/div/div[3]/div/div/div/div/div/div[1]/div[2]/div[3]/div[3]/div/div[2]/h2 to code
    echo `code`
    wait 5

    // go back to SLS
    https://vle.learning.moe.edu.sg/mrv/community-gallery/admin
    type otp as `code`
    click .field-set.type-button.otp-submit button
    wait 5 




click //a[@id="approved-link"]


// getting total_number of rows
read (//div[@class="v-data-footer__pagination"])[2] to pagination
js total = parseInt(pagination.split("of")[1].trim());
echo total = `total`
// 7300 in CG featured
rowCnt = 1
// might want to change this to save time crawling all the assigned
tableCnt = 57
for j from 1 to tableCnt
    click //button[@class='v-btn v-btn--flat v-btn--icon v-btn--round v-btn--text theme--light v-size--default']//i[@class='v-icon notranslate mdi mdi-chevron-right theme--light']
// block of code to move to correct table number


pending = []
// WRITING TO FILE , Create if missing, replace if present
//dump `(['S/N', 'Title', 'Type', 'Subject', 'Level', 'School','Zone','Date','Reviewer','URL' ])` to publish_list.csv
//dump `([ 'Type', 'Title','Subject','Subject Category', 'Level','Level Category','Level Type','Date','Month Featured','LEType','URL','View','Status','number' ])` to publish_list.csv


// the number cannot to greater than 6000 ?
// speculate TagUI cannot support large numbers?

// change here
startnumber = 1
numberoflessonstocrawl = 600

for i from startnumber to numberoflessonstocrawl
    //live
    // loop to skip the specified number of tables
    click //a[@id="approved-link"]
    read //*[@id="approved"]/div/div/div/div[1]/table/tbody/tr[`rowCnt`]/td[2]/div/span to typelc
    echo `rowCnt` = `typelc`
    if typelc equals to "Course"
        //live
        //read //*[@id="approved"]/div/div/div/div[1]/table/tbody/tr[`rowCnt`]/td[1]/div/div/div[1]/svg/path[1] to gameon
        //echo `gameon`
        //if present('/html[1]/body[1]/div[1]/main[1]/div[1]/div[1]/section[1]/div[1]/div[2]/div[1]/div[2]/div[2]/div[1]/div[1]/div[1]/div[1]/table[1]/tbody[1]/tr[`rowCnt`]/td[1]/div[1]/div[1]/div[1]/*[name()='svg'][1]')
        // css path to the first column in the row
        //dom_json = {css_path: "#pending table > tbody > tr:nth-child(" + rowCnt + ") > td:nth-child(1) > div "}
        // checking for the 'game' icon
        //dom return document.querySelector(dom_json.css_path + " > button.cv-tooltip") ? 1 : -1
        xp = '//*[@id="approved"]/div/div/div/div[1]/table/tbody/tr'
        //rows = count(xp)
        xp2 = xp + '[' + rowCnt + ']/td[1]/div/div/div[1]/*[local-name()="svg" and @name="Game24"]'
        //gameon = dom_result == -1 ? 0 : 1
        //gameon = //*[local-name()='svg' and @name='Game24']
        if  present(xp2)   
            echo in row = `rowCnt`, gamification found, do nothing
            
        else
            // go to URL of course
            click //*[@id="approved"]/div/div/div/div[1]/table/tbody/tr[`rowCnt`]/td[1]/div/div/div/a
            // edit it
            wait 1
            click cv-tooltip bx--tooltip__trigger bx--tooltip--a11y bx--tooltip--bottom bx--tooltip--align-center
            // 
            // menu three dots
            wait 1
            click //button[@aria-controls="lesson-submenu"]
            //live
            // game 
            wait 1
            click gamification community
            wait 3
            // on toogle
            click bx--toggle-input__label
            // save
            click //button[@class='cv-button bx--btn bx--btn--primary bx--btn--field bx--btn--icon-only']//*[name()='svg']
            //exit X
            click button close sls-icon
            // tick to save and exit completely
            click //button[@type='button']//*[name()='svg']
            // click three dot again
            click /html[1]/body[1]/div[1]/header[1]/div[2]/button[4]/*[name()='svg'][1]
            // exit course editor
            click //button[normalize-space()='Exit Course Editor']
            // loop to skip the specified number of tables
            
            for j from 1 to tableCnt
                click //button[@class='v-btn v-btn--flat v-btn--icon v-btn--round v-btn--text theme--light v-size--default']//i[@class='v-icon notranslate mdi mdi-chevron-right theme--light']
                echo tableCnt = `tableCnt` and j = `j`
    //js console.log(pending[pending.length-1])
    js rowCnt++;
    echo line 116 = `rowCnt`
    if (rowCnt == 21)
        {
            click //button[@class='v-btn v-btn--flat v-btn--icon v-btn--round v-btn--text theme--light v-size--default']//i[@class='v-icon notranslate mdi mdi-chevron-right theme--light']
            js tableCnt++; // maybe TagUI code has no ++ so use js
            echo tableCnt = `tableCnt`
            rowCnt = 1
            echo rowCnt = `rowCnt`
            echo i = `i` 
            wait 2
        }