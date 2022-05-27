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

rowCnt = 1
// might want to change this to save time crawling all the assigned
tableCnt = 0


pending = []
// WRITING TO FILE , Create if missing, replace if present
//dump `(['S/N', 'Title', 'Type', 'Subject', 'Level', 'School','Zone','Date','Reviewer','URL' ])` to publish_list.csv
dump `([ 'Type', 'Title','Subject','Subject Category', 'Level','Level Category','Level Type','Date','Month Featured','LEType','URL','View','Status','number' ])` to publish_list.csv


// the number cannot to greater than 6000 ?
// speculate TagUI cannot support large numbers?

// change here
numberoflessonstocrawl = 60

for i from 1 to numberoflessonstocrawl
    
    // loop to skip the specified number of tables
    click //a[@id="approved-link"]
    echo managed to click on approved?  
    for j from 1 to tableCnt
        click //div[@id='approved']//i[@class='v-icon notranslate mdi mdi-chevron-right theme--light']
        echo tableCnt = `tableCnt`
        //click approved .v-icon.notranslate.mdi.mdi-chevron-right.theme--light
        //click //button[@class='v-btn v-btn--flat v-btn--icon v-btn--round v-btn--text theme--light v-size--default']//i[@class='v-icon notranslate mdi mdi-chevron-right theme--light']
        //click //div[@id='pending']//i[@class='v-icon notranslate mdi mdi-chevron-right theme--light']
        //click //button[@class='v-btn v-btn--flat v-btn--icon v-btn--round v-btn--text theme--light v-size--default']//i[@class='v-icon notranslate mdi mdi-chevron-right theme--light']

    //read data on table first
    //read /html/body/div[1]/main/div/div/section/div/div[2]/div/div[2]/div[1]/div/div/div/div[1]/table/tbody/tr[1]/td[4]/div/span to course
    read //*[@id="approved"]/div/div/div/div[1]/table/tbody/tr[`rowCnt`]/td[1]/div/div/span to title
    echo `title`
    read //*[@id="approved"]/div/div/div/div[1]/table/tbody/tr[`rowCnt`]/td[2]/div/span to typelc
    echo `typelc`
    //read //body[1]/div[1]/main[1]/div[1]/div[1]/section[1]/div[1]/div[2]/div[1]/div[2]/div[1]/div[1]/div[1]/div[1]/div[1]/table[1]/tbody[1]/tr[1]/td[3]/div[1]/span[1] to subject
    read //*[@id="approved"]/div/div/div/div[1]/table/tbody/tr[`rowCnt`]/td[3]/div/span to subject
    echo `subject`
    read //*[@id="approved"]/div/div/div/div[1]/table/tbody/tr[`rowCnt`]/td[4]/div/span to level
    echo `level`
    read //*[@id="approved"]/div/div/div/div[1]/table/tbody/tr[`rowCnt`]/td[5]/div/span[1] to school
    echo `school`
    read //*[@id="approved"]/div/div/div/div[1]/table/tbody/tr[`rowCnt`]/td[5]/div/span[2] to zone
    echo `zone`
    read //*[@id="approved"]/div/div/div/div[1]/table/tbody/tr[`rowCnt`]/td[6]/div/span[1] to date
    echo `date`
    read //*[@id="approved"]/div/div/div/div[1]/table/tbody/tr[`rowCnt`]/td[6]/div/span[2] to reviewer
    echo `reviewer`
    // trimming the reviewer string to remove the 'By '
    js reviewer = reviewer.slice(3);

    click //*[@id="approved"]/div/div/div/div[1]/table/tbody/tr[`rowCnt`]/td[1]/div/div/div/a
    js link = url()
    if (link contains 'home') or  (link equals to  'https://vle.learning.moe.edu.sg/mrv/community-gallery/admin')
        // click again
        // goes back to previous page
        dom window.history.back()
        // change tab
        click //a[@id="approved-link"]
        //click open
        click //*[@id="approved"]/div/div/div/div[1]/table/tbody/tr[`rowCnt`]/td[1]/div/div/div/a
        js link = url()

    // actual link is without admin/ so need to remove using code
    link = link.replace('admin/','')
    echo `link`
    wait 2
    // didnt work well, some error in SLS
    //dom window.history.back();
    // use visit URL method more stable
    https://vle.learning.moe.edu.sg/mrv/community-gallery/admin
    click //a[@id="approved-link"]
    //js pending.push([i, title, typelc, subject, level, school, zone, date, reviewer,link])
    js pending.push([typelc, title, subject,'Subject Category',level,'Level Category','Level Type',  date,'Month Featured', 'LEType',link,'View','Status',i])
    // write file line by line so if breaks, still got some runs data done.
    write `csv_row(pending[pending.length - 1])` to publish_list.csv
    js console.log(pending[pending.length-1])
    js rowCnt++;
    if (rowCnt == 21)
        {
            //click //button[@class='v-btn v-btn--flat v-btn--icon v-btn--round v-btn--text theme--light v-size--default']//i[@class='v-icon notranslate mdi mdi-chevron-right theme--light']
            js tableCnt++; // maybe TagUI code has no ++ so use js
            rowCnt = 1
            wait 2
        }