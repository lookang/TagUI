https://mail.google.com/mail/u/0/#inbox

load pendingreview_list.csv to pending_table

// https://rpa-sg.org/TagUI-Tips-Techniques/how-to-read-a-csv-file-part-2-multiple-columns.php
// pre process csv to array
array_title = [] // 1 is title
array_date_submitted = [] 
array_url = [] // 10 is url
array_due_date = []
load pendingreview_list.csv to lines
//echo `lines`
array_lines = lines.split('\n')
//echo `array_lines`
for (n=0; n<array_lines.length; n++) 
{
    items = array_lines[n].split(',')
    array_title[n] = items[1].trim()
    array_date_submitted[n] = items[6].trim()
    array_url[n] = items[8].trim()
    array_due_date[n] = items[15].trim()

echo `array_url[n]`
echo `array_date_submitted[n]`
date_submitted = array_date_submitted[n]
echo 1 = `date_submitted`
date_submitted = new Date(date_submitted)
echo 2 = `date_submitted`
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
difference = difference/(1000*60*60*24)
js difference = Math.ceil(difference)
echo `difference`
//7.965694664351852
//14/10/21
// assume weekend +2, so 5+2 (margin) = 7
if (difference > 8) 
    type //*[@id="gs_lc50"]/input[1] as `array_url[1]`
    // trigger search, click search icon
    click gb_hf gb_if
    // assume full screen and primary monitor and the (500,270) is based on first email on a MacOS primary monitor
    // click (500,270)
    // (500,270) is guessed by human
    // first email
    //click zA yO
    //click (//table)[8]//tr[1]
    // some magic code that seems to work need to test more
    click (//tr[@role='row'])[51]
    //rclick (500,270)
    click Reply all
    type Message Body as Dear CG Admin, \nThis lesson has been detected as `difference` days after the teacher' submission `date_submitted` date for review. This email serves as a gentle reminder to return/publish this lesson by today or next working day please, in view of the Public Service Commitment of 5 working days https://www.psd.gov.sg/who-we-are/our-service-commitment Thank you. Regards.
    // click Send ‪(⌘Enter)‬


}
////////////////////////////////////////////////////////








wait 5000