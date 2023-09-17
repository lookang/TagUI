// assume self login to SLS
//live
// first file only click to generate
// second file only click to download
// this split is based on the limitation of current SLS behavior 
https://vle.learning.moe.edu.sg/
if exist ('Login With SLS')
    click //button[normalize-space()='Login With SLS']
    click //button[normalize-space()='Login']
https://vle.learning.moe.edu.sg/manage-resource?keyword=&location=MOE&resource=LESSON&ownerGroups=1121,1174,1163&status=ALL
//live
// change 
ask Which row is the lesson to extract data from? expect 1 to 20 etc.
echo `ask_result` 
//row = 2
row = ask_result

// first name is ADMIRALTY PRIMARY SCHOOL
// because the data in notication is group by 20, i recommend running by 20 to sync up with the notification page
// the links also may not lasts so long to run 100s, so 20 per run is optimised.
ask Start? expecting 1 or 21 or 41 etc depending on the stage of the RPA
echo `ask_result` 
start = ask_result
ask End? expecting 20 or 40 or 60 etc depending on the stage of the RPA
echo `ask_result` 
end = ask_result

for n from start to end
    echo counter n = `n`
    click (//*[name()='svg'][@name='Kebab24'])[`row`]
    click (//span[@class='bx--overflow-menu-options__option-content'][normalize-space()='Download Response'])[2]
    click //input[@placeholder='Select School']
    click /html[1]/body[1]/div[3]/div[1]/div[1]/div[2]/div[1]/form[1]/dl[1]/dd[1]/div[1]/div[1]/div[2]/div[`n`]/div[1]
    click Generate
    // assume SLS takes 5 seconds or less to generate
    wait 1
    // click (//*[name()='svg'][@name='Bell32'])[1]
    // click (//b[contains(text(),'SLS')])[1]
    // https://vle.learning.moe.edu.sg/manage-resource?keyword=&location=MOE&resource=LESSON&ownerGroups=1121,1174,1163&status=ALL
    // live

// second is 
//click /html[1]/body[1]/div[3]/div[1]/div[1]/div[2]/div[1]/form[1]/dl[1]/dd[1]/div[1]/div[1]/div[2]/div[2]/div[1]
