//https://tagui.readthedocs.io/en/latest/reference.html
js begin
//
js finish




//visit URL
//https://vle.learning.moe.edu.sg/mrv/community-gallery/admin
//https://vle.learning.moe.edu.sg/mrv/admin/user/manage
https://vle.learning.moe.edu.sg/mrv/my-library/lesson/edit/6cd60505-666f-4b0a-856d-1de17c4cb6b4/cover
// doesnt work
//keyboard [fn][F]
//live
//assume no need to extra login
if present('//button[@id="login-button"]')
    click .button.login
    wait 5

    
    https://mail.google.com/mail/u/0/#inbox"
    // Click Sign in 
    wait 5
    // click the first email by notifications@sls.ufinity.com in the table
    click //*[@email="notifications@sls.ufinity.com"]/ancestor-or-self::tr
    //code = ""
    //read //div[7]/div[3]/div/div[2]/div[1]/div[2]/div/div/div/div/div[2]/div/div[1]/div/div[2]/div/table/tr/td[1]/div[2]/div[2]/div/div[3]/div/div/div/div/div/div[1]/div[2]/div[3]/div[3]/div/div[2]/h2 to code
    // new otp xpath
    read /html/body/div[7]/div[3]/div/div[2]/div[2]/div/div/div/div/div[2]/div/div[1]/div/div[2]/div/table/tr/td[1]/div[2]/div[2]/div/div[3]/div/div/div/div/div/div[1]/div[2]/div[3]/div[3]/div/div[2]/h2 to code
    echo `code`
    wait 5

    // go back to SLS
    https://vle.learning.moe.edu.sg/mrv/my-library/lesson/edit/6cd60505-666f-4b0a-856d-1de17c4cb6b4/cover
    type otp as `code`
    click .field-set.type-button.otp-submit button
    wait 5 

//live
//https://ccpm.learning.moe.edu.sg/user/vle
// to go a course
//https://vle.learning.moe.edu.sg/mrv/my-library/lesson/view/6cd60505-666f-4b0a-856d-1de17c4cb6b4/cover
https://vle.learning.moe.edu.sg/mrv/my-library/lesson/edit/6cd60505-666f-4b0a-856d-1de17c4cb6b4/cover


//live

click //a[@class='cv-link view-more bx--link']
click //p[@class='bx--accordion__title']
click //input[@placeholder='Select Subject']




start = 1
end = 159
//live
for i from start to end 
    read /html/body/div[3]/div/div/div[2]/div/div[2]/div/div/div/div/form/div[3]/dl[2]/dd/div/div/ul/li/div/div/div/dl[1]/dd/div/div/div[2]/div[`i`]/div to subject
    //read /html/body/div[3]/div/div/div[2]/div/div[2]/div/div/div/div/form/div[3]/dl[2]/dd/div/div/ul/li/div/div/div/dl[1]/dd/div/div/div[2]/div[3]/div 
    echo `subject`
    //table v-data-table__wrapper to page`i`.csv
    write `subject` to subjectresultrpa.csv



wait 5000