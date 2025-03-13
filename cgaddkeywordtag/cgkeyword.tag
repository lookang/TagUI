// tagui cgkeyword.tag SLS_CG_2024_11.csv

//echo `title`
//echo `url'

//======================================================
//  SLS VLE Script
//  ----------------------------------------------------
//  Purpose: Automate add keyword tags to Community Gallery Modules if from title contains Examination and SBA 
//  Author:  [lawrence_wee@moe.gov.sg]
//  Date:    [20250313]
//======================================================

//------------------------------------------------------
// STEP 1 - OPEN SLS AND LOGIN
//------------------------------------------------------
https://vle.learning.moe.edu.sg/login
wait 5



// Navigate to the SLS login page
https://vle.learning.moe.edu.sg/login
//wait 5

//live
wait 3
if iteration = 1
    if present("//button[normalize-space()='Login With SLS']")
        click //button[normalize-space()='Login With SLS']
        type bx--text-input as [clear]MOE-09615H
        click //input[@placeholder='SLS Password'] 
        type //input[@placeholder='SLS Password'] as [clear]Shanshan1!!!!!!!!
        click //button[normalize-space()='Login']

// do rest of the steps for every iteration
// Visit the URLs
fulleditableURLsubstring = url.substring(8)
https://`fulleditableURLsubstring`

echo "i = "`iteration`
modifiedUrl = url.replace('/mrv', '').replace('/community-gallery/', '/community-gallery/admin/');
modifiedUrl2 = modifiedUrl.substring(8)
https://`modifiedUrl2`
wait 5
//live
read //dl[@class='field-set title']//dd[@class='field-value'] to title
echo `title`

//------------------------------------------------------
// STEP 2 - CHECK FOR "(XXXX)" IN TITLE
//------------------------------------------------------

pattern = /\(\d+\)/;  // Matches (XXXX), e.g., (1227), (2020)
match_found = title.match(pattern);  // Search only in title
echo `match_found`


// Assign `match_found` from JS to TagUI variable `found`
found = `match_found`


if `found` not equals to ""
    echo 'Found (XXXX): ' `found`
else
    echo 'No (XXXX) found.'


//------------------------------------------------------
// STEP 3 - RUN ACTIONS IF TITLE CONTAINS "SBA" AND (XXXX) EXISTS
//------------------------------------------------------
echo title = `title`
if  (title contains "SBA") 
    if (found not equals to "")
        click (//*[name()='svg'][@name='Pen32'])[1]
        click (//*[name()='svg'][@name='Settings24'])[1]
        wait 3
        type //div[@class='bx--text-input__field-wrapper']//input[@class='bx--text-input'] as Past paper[enter]
        wait 3
        if present("//button[normalize-space()='Cancel']")
            click //button[normalize-space()='Cancel']
        type //div[@class='bx--text-input__field-wrapper']//input[@class='bx--text-input'] as Exam paper[enter]
        wait 3
        if present("//button[normalize-space()='Cancel']")
            click //button[normalize-space()='Cancel']
        type //div[@class='bx--text-input__field-wrapper']//input[@class='bx--text-input'] as Practice paper[enter]
        wait 3
        if present("//button[normalize-space()='Cancel']")
            click //button[normalize-space()='Cancel']

        click (//*[name()='svg'][@name='Save24'])[1]
        wait 3
        click (//*[name()='svg'][@name='Close24'])[1]
        wait 3

        click (//*[name()='svg'][@name='CheckmarkCircle32'])[1]