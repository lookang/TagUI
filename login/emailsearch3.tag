//https://stackoverflow.com/questions/37069186/calculate-working-days-between-two-dates-in-javascript-excepts-holidays/37069478



// create the xlsm from csv?
// read csv into data
data = [pendingreview_list.csv]pendingreview_list!A:Z
// write xlsx
[pendingreview_list.xlsx]pendingreview_list!A1 = data
// my mac has some kind of bug, need to click mac excel twice to launch, so may need to help manually click excel file
// Open gmail (assumes that user has already logged in previously)
ask 1 slscgbot@gmail.com or 2 wee_loo_kang@moe.edu.sg ?
echo `ask_result`
if ask_result contain '1'
    https://mail.google.com/mail/u/0/#inbox
else
    https://mail.google.com/mail/u/1/?ogbl#inbox

wait 3



//https://mail.google.com/mail/u/0/#inbox
// load pendingreview_list.xls to pending_table
// https://rpa-sg.org/TagUI-Tips-Techniques/how-to-read-a-csv-file-part-2-multiple-columns.php
// pre process csv to array
// B2:B50 is based on the xlsm starting, avoid the first header , 50 is just a guess assume no more that 50 lessons
array_title = [pendingreview_list.xlsx]pendingreview_list!B1:B50 
echo `array_title[0]`
array_date_submitted = [pendingreview_list.xlsx]pendingreview_list!G1:G50 
echo 0 is >`array_date_submitted[0]`
echo 1 is >>`array_date_submitted[1]`
echo 2 is >>>`array_date_submitted[2]`
echo 3 is >>>>`array_date_submitted[3]`
//0 is >date Tuesday
//1 is >>19 October 2021 at 12:00:00 AM
//2 is >>>date Tuesday
//3 is >>>>19 October 2021 at 12:00:00 AM

array_url = [pendingreview_list.xlsx]pendingreview_list!I1:I50 
array_due_date = [pendingreview_list.xlsx]pendingreview_list!N1:N50 
//date_submitted = [pendingreview_list.xlsm]pendingreview_list!N2:N50 

vartoloop =10
for (n=1; n<vartoloop; n++) 


    echo URl is `array_url[n]`
    // echo URLdirect is `[pendingreview_list.xlsm]pendingreview_list!G`n`:G50`
    //echo Submitted is  `array_date_submitted[n]`
    //date_submitted = array_date_submitted[n]
    //reference_cnt = 2*n+1
    reference_cnt = n
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
    //difference = date_today - date_submitted
    js begin
    var holidays = ['1 Jan 2022', '1 Feb 2022', '2 Feb 2022', '15 Apr 2022', '2 May 2022' ,'3 May 2022','10 Jul 2022','11 Jul 2022','9 Aug 2022','24 Oct 2022','26 Dec 2022' ];
    function getBusinessDatesCount(startDate, endDate) {
    var count = 0;
    const curDate = new Date(startDate.getTime());
    while (curDate <= endDate) {
        const dayOfWeek = curDate.getDay();
        //https://stackoverflow.com/questions/37069186/calculate-working-days-between-two-dates-in-javascript-excepts-holidays/37069478
        
        if((dayOfWeek !== 0 && dayOfWeek !== 6)) count++;
        //for (var i=0;i<holidays.length; i++){
        //    curDate==holidays[i]
        //    alert(curDate);
        //    alert(holidays[i]);
        //    count--;
        //}
        curDate.setDate(curDate.getDate() + 1);
    }
    //alert(count);
    return count;
    }
    difference= getBusinessDatesCount(date_submitted, date_today)
    js finish
    
    //difference = date_today - array_date_submitted[2*n+1]
    //difference = difference/(1000*60*60*24)
    //js difference = Math.floor(difference)-1-1
    echo difference is `difference`
    //7.965694664351852
    //14/10/21
    // assume weekend +2, so 5+2 (margin) = 5
    if (difference > 5) 
        type //*[@id="gs_lc50"]/input[1] as [clear]`array_url[n]`
        // trigger search, click search icon
        click /html[1]/body[1]/div[7]/div[3]/div[1]/div[1]/div[3]/header[1]/div[2]/div[2]/div[2]/form[1]/button[4]/*[name()='svg'][1]/*[name()='path'][1]
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
            type Message Body as Dear CG Admin, \nThis lesson has been detected as `difference` days (includes holidays so the number looks bigger than usual) after the teacher' submission `date_submitted` date for review. This email serves as a gentle reminder to return/publish this lesson by today or next working day please, in view of the Public Service Commitment of 5 working days https://www.psd.gov.sg/who-we-are/our-service-commitment Thank you. Regards.
            // dont send immediately for human check
            click //div[@role="button"][contains(@data-tooltip, "Send")] 



////////////////////////////////////////////////////////








wait 5000