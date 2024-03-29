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

https://ccpm.learning.moe.edu.sg/user/ccpm
ask Key in the Owner Group to extract table of data example type number of name  CCE, Combined_Subjects, Commerce, CSE, Digital_Literacy, Economics, EL_Reading, Exer_Sport_Sci, Foreign_Lang, LS_Drama, LS_Music, Makers,  MOE_ITE_AS,  NTS_DLM, PreU_Art, PreU_CL, PreU_Dance, PreU_Geog, PreU_GP, PreU_H2_Comp, PreU_Hist, PreU_LIT, PreU_MA, PreU_ML, PreU_Music, PreU_PE, PreU_Sci, PreU_TL, PreU_TSD, Pri_Art, Pri_CL, Pri_Dance, Pri_Drama, Pri_EL, Pri_MA, Pri_ML, Pri_Music, Pri_PE, Pri_Sci, Pri_SS, Pri_TL, Sec_Art, Sec_CL, Sec_Comp, Sec_CPA, Sec_D&T, Sec_Dance, Sec_EL, Sec_Electr, Sec_EN(A)_SS, Sec_F&N, Sec_FCE, Sec_FS, Sec_Geog, Sec_Hist, Sec_LIT, Sec_MA,Sec_ML,Sec_N(T)_SS,Sec_PE,Sec_Sci, Sec_TL, SEN Support_SDR, SEN Support_TRANSIT,SIL, SLS_Office, US_Drama ,US_Music               
echo `ask_result`

click Select Owner Group
click `ask_result`
//click Select IAMS Status
//click ACTIVE
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
dump `temp` to resultccpm`ask_result`.csv
//wait 5
for i from 2 to pages 
    load page`i`.csv to temp
    //echo `temp`
    //write for adding on to the same file
    write `temp` to resultccpm`ask_result`.csv
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