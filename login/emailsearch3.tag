// create the xlsm from csv?



https://mail.google.com/mail/u/0/#inbox


// load pendingreview_list.xls to pending_table

// https://rpa-sg.org/TagUI-Tips-Techniques/how-to-read-a-csv-file-part-2-multiple-columns.php
// pre process csv to array
// B2:B50 is based on the xlsm starting, avoid the first header , 50 is just a guess assume no more that 50 lessons
array_title = [pendingreview_list.xlsm]pendingreview_list!B2:B50 
echo `array_title[0]`
array_date_submitted = [pendingreview_list.xlsm]pendingreview_list!G2:G50 
echo 0 is >`array_date_submitted[0]`
echo 1 is >>`array_date_submitted[1]`
echo 2 is >>>`array_date_submitted[2]`
echo 3 is >>>>`array_date_submitted[3]`
//0 is >date Tuesday
//1 is >>19 October 2021 at 12:00:00 AM
//2 is >>>date Tuesday
//3 is >>>>19 October 2021 at 12:00:00 AM

array_url = [pendingreview_list.xlsm]pendingreview_list!I2:I50 
array_due_date = [pendingreview_list.xlsm]pendingreview_list!N2:N50 
//date_submitted = [pendingreview_list.xlsm]pendingreview_list!N2:N50 

for (n=0; n<50; n++) 


    echo URl is `array_url[n]`
    // echo URLdirect is `[pendingreview_list.xlsm]pendingreview_list!G`n`:G50`
    //echo Submitted is  `array_date_submitted[n]`
    //date_submitted = array_date_submitted[n]
    reference_cnt = 2*n+1
    echo reference_cnt = `reference_cnt`
    newstring = array_date_submitted[reference_cnt]
    echo newstring = `newstring`
    //length = newstring.toString().length
    //echo length = `length`
    // assume string  at 12:00:00 AM is always 15
    //reallength = length - 15
    //echo reallength `reallength`
    //js newstrings = newstring.substring(0,reallength)
    //js newstrings = newstring.toString().substring(0,reallength)
    //echo newstrings =  `newstrings` 
    //date_submitted = new Date('`newstring`')
    date_submitted = new Date('`newstring`')
    //date_submitted = new Date('19 October 2021')
    //echo 1 =>>>>> `date_submitted`
    echo date_submitted = `date_submitted`
    //date_submitted = new Date(date_submitted)
    //echo 2 = `date_submitted`
    //09 Oct 2021
    //date_submitted = new Date(date_submitted)
    //echo 2 =`date_submitted`
    //Sat Oct 09 2021 00:00:00 GMT+0800 (+08)
    ////////////////////////////////////////////////////////
    // date
    date_today = new Date()
    echo today is `date_today`
    //1634051541612 16 October 2021
    //https://sebhastian.com/javascript-subtracting-dates/
    difference = date_today - date_submitted
    //difference = date_today - array_date_submitted[2*n+1]
    difference = difference/(1000*60*60*24)
    js difference = Math.floor(difference)-1-1
    echo difference is `difference`
    //7.965694664351852
    //14/10/21
    // assume weekend +2, so 5+2 (margin) = 5
    if (difference > 5) 
        type //*[@id="gs_lc50"]/input[1] as [clear]`array_url[n]`
        // trigger search, click search icon
        click gb_hf gb_if
        // assume full screen and primary monitor and the (500,270) is based on first email on a MacOS primary monitor
        // click (500,270)
        // (500,270) is guessed by human
        // first email
        //click zA yO
        //click (//table)[8]//tr[1]
        // some magic code that seems to work need to test more
        wait 2
        if present ('(//tr[@role="row"])[51]')
            click (//tr[@role='row'])[51]
            //rclick (500,270)
            click T-I J-J5-Ji T-I-Js-Gs aap T-I-awG T-I-ax7 L3
            click Reply to all
            type Message Body as Dear CG Admin, \nThis lesson has been detected as `difference` days (includes Sat n Sun so the numbers look bigger than usual) after the teacher' submission `date_submitted` date for review. This email serves as a gentle reminder to return/publish this lesson by today or next working day please, in view of the Public Service Commitment of 5 working days https://www.psd.gov.sg/who-we-are/our-service-commitment Thank you. Regards.
            // dont send immediately for human check
            click //div[@role="button"][contains(@data-tooltip, "Send")] 



////////////////////////////////////////////////////////








wait 5000