//https://tagui.readthedocs.io/en/latest/reference.html
js begin
//
js finish




//visit URL
https://vle.learning.moe.edu.sg/mrv/community-gallery/admin

//assume no login
if present('button login bx--btn bx--btn--primary')
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

https://ccpm.learning.moe.edu.sg/user/vle


click Select Role
click ALP Admin
click button submit user-search-submit

table user-table cover dataTable no-footer to page1.csv
click paginate_button next
table user-table cover dataTable no-footer to page2.csv
click paginate_button next
table user-table cover dataTable no-footer to page3.csv
click paginate_button next
table user-table cover dataTable no-footer to page4.csv
click paginate_button next
table user-table cover dataTable no-footer to page5.csv
click paginate_button next
table user-table cover dataTable no-footer to page6.csv
click paginate_button next


load page1.csv to page1
// dump for first line that starts a new file
dump `page1` to result.csv
load page2.csv to page2
//write for adding on to the same file
write `page2` to result.csv
load page3.csv to page3
write `page3` to result.csv
load page4.csv to page4
write `page4` to result.csv
load page5.csv to page5
write `page5` to result.csv
load page6.csv to page6
write `page6` to result.csv

// navigate to folder and see the result.csv file

//assume ok
//click Submit
// confirm look 
wait 5000