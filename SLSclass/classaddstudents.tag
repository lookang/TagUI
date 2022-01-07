// this flow must be done in the primary monitor as it uses computer vision to click the png
// the type didnt work so use png to identify stuff and bring into focus for the keyboard to work
//https://tagui.readthedocs.io/en/latest/reference.html
//tableofemails = [Name list for Pri pilot.xlsx]2021!E3:E100 
// change this based on the xlsx data for ease of reading
tableofemails = [Name list for Pri pilot_SLS Grouping 2022v2.xlsx]2022!E2:E165  
// change this to suit the xlsx as flow may stop prematurely and restart with the rest of the incomplete data
startrow = 85
echo `tableofemails[startrow]`

//visit URL
https://vle.learning.moe.edu.sg/mrv/class-group

//assume no login
if present('.button.login')
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




// assume class created
//click ADD NEW GROUP

//type bx--text-input bx--text-input--invalid as group name
//click bx--list-box__field
//click 2023
//type //div[@class='paragraph'] as Description

//click //h4[normalize-space()='Pri Pilot research team']
//click //a[@id='admin-link']

//short cut
//https://vle.learning.moe.edu.sg/mrv/studentgroup/5e20e86c-1744-4cd7-9161-c31f128eefc8?tab=admin

https://vle.learning.moe.edu.sg/mrv/studentgroup/46e34479-2033-4471-874e-5e9476770dd5?tab=admin

//click VIEW
click VIEW & EDIT

// change here as the list grows after samuel 14
//startrow = 13
// sls limit manually change based on what is the last item on the xlsx
total = 165

for i from startrow to total 
    click Add Student
    wait 1
    // must have full screen to detect this correctly
    click  Teacher as Student 
    wait 1
    // may not need to change to All Schools if emails are all HQ, just to be safe
    click //input[@placeholder='MOE HQ'] 
    wait 1
    // this is a silly thing in SLS, why not make default as All Schools ? so as it support one MOE collaboration in a a class
    click All Schools
    wait 1
    
    //click (//*[name()='svg'][@class='search-toggle sls-icon'])[2]
    //type //input[@id='uid-1ae35348-aa5f-4b3e-9e01-d50cf3d10300'] as `tableofemails[i]`[enter]
    
    //keyboard step needs to have the browser/input box in focus
    //click search.png
    // not sure but may need 2 clicks
    //if present('search.png')
    //    click search.png
    //if present('findteachers.png')
    //    click findteachers.png
    // the x icon to get back the magnifying glass icon
    click //button[@type='button']//span[@class='icon']//*[name()='svg']
    wait 1

    //click //div[@class='search-bar-wrapper _auto-collapse _has-filter _filter-type-dropdown']//div[@class='search-bar']//*[name()='svg']
    click search.png
    wait 2
    keyboard `tableofemails[i]`[enter]
    //type /html[1]/body[1]/div[3]/div[2]/div[1]/div[2]/div[1]/div[4]/div[1]/div[1]/div[1]/div[1]/input[1] as `tableofemails[i]` [enter]
    //echo second try enter 
    //type /html[1]/body[1]/div[3]/div[2]/div[1]/div[2]/div[1]/div[4]/div[1]/div[1]/div[1]/div[1]/input[1] as [enter]
    //type /html[1]/body[1]/div[3]/div[2]/div[1]/div[2]/div[1]/div[4]/div[1]/div[1]/div[1]/div[1]/input[1] as abc[enter]
    
    
    //click /html[1]/body[1]/div[3]/div[2]/div[1]/div[2]/div[1]/div[4]/div[1]/div[1]/div[1]/div[1]/input[1]
    //echo if cannot trigger keyboard, user type in keyboard to return
    //keyboard [enter]
    // something about computer vision that make the input box as focus 
    wait 5
    //click search.png
    //keyboard `tableofemails[i]`[enter] 
    // select all names, assume names are unique and only one
    //click v-data-table__checkbox v-simple-checkbox
    // //tbody/tr[1]/td[1]/div[1]/i[1] is the checkbox of first item in the table
    if present('//tbody/tr[1]/td[1]/div[1]/i[1]')
        //click v-icon notranslate mdi mdi-checkbox-blank-outline theme--light
        // improve to click only the first item in the table search
        click //tbody/tr[1]/td[1]/div[1]/i[1]
        click //span[normalize-space()='Add']
        click cv-button-set bx--btn-set
        click OK
    else 
        //simulate like no user found and click back
        click ArrowLeft24
