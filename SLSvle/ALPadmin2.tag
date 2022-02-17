//https://tagui.readthedocs.io/en/latest/reference.html
js begin
//
js finish




//visit URL
https://vle.learning.moe.edu.sg/mrv/community-gallery/admin

//assume no need to extra login
if present('button login bx--btn bx--btn--primary')
    click .button.login
    wait 5

    
    https://mail.google.com/mail/u/0/#inbox"
    // Click Sign in 
    wait 5
    // click the first email by notifications@sls.ufinity.com in the table
    click //*[@email="notifications@sls.ufinity.com"]/ancestor-or-self::tr
    //code = ""
    read //div[7]/div[3]/div/div[2]/div[1]/div[2]/div/div/div/div/div[2]/div/div[1]/div/div[2]/div/table/tr/td[1]/div[2]/div[2]/div/div[3]/div/div/div/div/div/div[1]/div[2]/div[3]/div[3]/div/div[2]/h2 to code
    echo `code`
    wait 5

    // go back to SLS
    https://vle.learning.moe.edu.sg/mrv/community-gallery/admin
    type otp as `code`
    click .field-set.type-button.otp-submit button
    wait 5 

https://ccpm.learning.moe.edu.sg/user/vle

click Select SLS Account Status
click //span[normalize-space()='Activated']
click Select Role
click ALP Admin
click button submit user-search-submit

startrow = 1
// getting total_number of rows
read DataTables_Table_0_info to page
//echo page 
//page = Showing 1 to 20 of 145 result(s)
js total = parseInt(page.split("of")[1].trim());
// echo total
// total = 145
//total = /html[1]/body[1]/main[1]/div[1]/div[1]/div[1]/div[1]/article[1]/div[2]/section[1]/div[1]/div[2]/div[1]/div[1]/div[2]/div[2]/div[3]/div[2]/span[1]/a[6]
js pages = Math.ceil(total/20)
for i from startrow to pages 
    table user-table cover dataTable no-footer to page`i`.csv
    click paginate_button next
//table user-table cover dataTable no-footer to page2.csv
//click paginate_button next
//table user-table cover dataTable no-footer to page3.csv
//click paginate_button next
//table user-table cover dataTable no-footer to page4.csv
//////click paginate_button next
////table user-table cover dataTable no-footer to page5.csv
//click paginate_button next
//table user-table cover dataTable no-footer to page6.csv
//click paginate_button next


load page1.csv to temp
//echo `temp`
// dump for first line that starts a new file
dump `temp` to result.csv
//wait 5
for i from 2 to pages 
    load page`i`.csv to temp
    //echo `temp`
    //write for adding on to the same file
    write `temp` to result.csv
    //wait 5
    
//load page3.csv to page3
//write `page3` to result.csv
////load page4.csv to page4
//write `page4` to result.csv
//load page5.csv to page5
//write `page5` to result.csv
//load page6.csv to page6
//write `page6` to result.csv

// navigate to folder and see the result.csv file

//assume ok
//click Submit
// confirm look 
//wait 5000