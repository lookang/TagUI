//https://tagui.readthedocs.io/en/latest/reference.html
js begin
//
js finish




//visit URL
https://vle.learning.moe.edu.sg/account-audit/jobs

//assume no need to extra login
if present('loginform')
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
    https://vle.learning.moe.edu.sg/account-audit/jobs
    type otp as `code`
    click .field-set.type-button.otp-submit button
    wait 5 

https://vle.learning.moe.edu.sg/account-audit/jobs

ask Key in 0 for Alp admin and 1 for Content Approver
echo `ask_result`
if ask_result contain '0'
    // do ntg default is working
else
    click MOE HQ Monthly Role Verification for Alp Admin
    click MOE HQ Monthly Role Verification for Content Approver
//click Select Role
//click ALP Admin
//click button submit user-search-submit

startrow = 1
// getting total_number of rows
read data-table-verify_info to page
//echo page 
//page = Showing 1 to 20 of 142 result(s)
js total = parseInt(page.split("of")[1].trim());
// echo total
// total = 142
//total = /html[1]/body[1]/main[1]/div[1]/div[1]/div[1]/div[1]/article[1]/div[2]/section[1]/div[1]/div[2]/div[1]/div[1]/div[2]/div[2]/div[3]/div[2]/span[1]/a[6]
js pages = Math.ceil(total/20)
for i from startrow to pages 
    table data-table-verify to pageaudit`i`.csv
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


load pageaudit1.csv to temp
//echo `temp`
// dump for first line that starts a new file
dump `temp` to resultaudit.csv
//wait 5
for i from 2 to pages 
    load pageaudit`i`.csv to temp
    //echo `temp`
    //write for adding on to the same file
    write `temp` to resultaudit.csv
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