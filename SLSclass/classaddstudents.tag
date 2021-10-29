//https://tagui.readthedocs.io/en/latest/reference.html
tableofemails = [Name list for Pri pilot.xlsx]2021!E3:E100 
echo `tableofemails[0]`

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
https://vle.learning.moe.edu.sg/mrv/studentgroup/5e20e86c-1744-4cd7-9161-c31f128eefc8?tab=admin
click VIEW & EDIT

// change here as the list grows after samuel 14
startrow = 13
// sls limit
total = 100

for i from startrow to total 
    click Add Student
    wait 2
    // must have full screen to detect this correctly
    click  Teacher as Student 
    wait 2
    // may not need to change to All Schools if emails are all HQ, just to be safe
    click //input[@placeholder='MOE HQ'] 
    wait 2
    click All Schools
    wait 2
    
    //click (//*[name()='svg'][@class='search-toggle sls-icon'])[2]
    //type //input[@id='uid-1ae35348-aa5f-4b3e-9e01-d50cf3d10300'] as `tableofemails[i]`[enter]
    
    //keyboard step needs to have the browser/input box in focus
    click search.png
    keyboard `tableofemails[i]`[enter]
    //type /html[1]/body[1]/div[3]/div[2]/div[1]/div[2]/div[1]/div[4]/div[1]/div[1]/div[1]/div[1]/input[1] as `tableofemails[i]`[enter]
    //click /html[1]/body[1]/div[3]/div[2]/div[1]/div[2]/div[1]/div[4]/div[1]/div[1]/div[1]/div[1]/input[1]
    //echo if cannot trigger keyboard, user type in keyboard to return
    //keyboard [enter]
    // something about computer vision that make the input box as focus 
    wait 5
    //click search.png
    //keyboard `tableofemails[i]`[enter] 
    // select all names, assume names are unique and only one
    //click v-data-table__checkbox v-simple-checkbox
    click v-icon notranslate mdi mdi-checkbox-blank-outline theme--light
    click //span[normalize-space()='Add']
    click cv-button-set bx--btn-set
    click OK
