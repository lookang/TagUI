// This script is designed to be run on the command line.
// type
// tagui keywordaddtoallquestionsintelligent2.tag url.csv
// The data for this script is prepared in a CSV file, as TagUI requires CSV instead of XLSX.
// The third column of the CSV file is used with the variable name 'p3' in the code.

// The data in the CSV file should look something like this:
// p1	p2	p3
// Forces and Their Effects [LSS]		https://vle.learning.moe.edu.sg/moe-library/lesson/view/341e6734-7c71-40f6-9a1e-e6ba8dc97fdf/cover
// Friction [LSS]		https://vle.learning.moe.edu.sg/mrv/moe-library/lesson/view/429087ea-4034-4f4e-8ceb-2f6934169760/cover
// Simple Machines [LSS]		https://vle.learning.moe.edu.sg/mrv/moe-library/lesson/view/fcf7150b-39b4-422f-a763-a5de1c950cb6/cover
// Columns p4 to p11 are keyword tags to be removed.
// 'add1' and 'add2' are keywords to be added.

// Please note the following limitations:
// - The keyword limit could be exhausted, causing an error.
// - A screen saver can interrupt the flow of the script. If necessary, set your screen saver to 'Never'.
// - While the script is running, it needs control of the keyboard and screen. Therefore, it's not advisable to multitask.
// - Sometimes SLS will pop up on the left bottom corner "rate your experience...", just close it manually to prevent it from disturbing the flow

// Navigate to the SLS login page
https://vle.learning.moe.edu.sg/login
//ask_result = 1
if iteration equals to 1
    ask 1 for SLS 2 for MIMS login
    echo `ask_result`
    if ask_result equals to 1
        // Click the "Login With SLS" button if present
        if present('//button[normalize-space()="Login With SLS"]')
            click //button[normalize-space()='Login With SLS']
        // Click the "Login" button if present
        if present("//button[normalize-space()='Login']")
            click //button[normalize-space()='Login']
    else if ask_result equals to 2
        // Click the "Login With MIMS" button if present
        if present("//button[normalize-space()='Login With MIMS']")
            click //button[normalize-space()='Login With MIMS']
            wait 3
            click (//span[@id='loginButton2'])[1]

// csv data not clean so need to do substring manipulation
wait 3
echo p3 is `p3`
// this code if else is to address the issue of url inconsistence some have mrv while some don't 
// Check if p3 contains "mrv"
if p3 contains "mrv"
    js indexPosition = 47
else
    js indexPosition = 43
js temp2 = p3.substring(0, indexPosition) + "/admin" + p3.substring(indexPosition)

// Log the value of temp2
echo Value of temp2:   `temp2`
// Remove the "https://" from temp2 to get temp
js temp = temp2.substring(8)
// Log the value of temp
echo Value of temp:  + `temp`
https://`temp` 

// first Unpublish
if present("(//*[name()='svg'][@name='Unpublish32'])")
    click (//*[name()='svg'][@name='Unpublish32'])
    click //span[normalize-space()='OK']
    // second open link
    click (//a[contains(text(),'Open')])[`1`]
    wait 3

// do all actions on new tab with lesson/view/ in the url
wait 4
popup lesson/view/
    {
    // cheat code to go edit mode
    js temp3 = temp.replace("view","edit")
    https://`temp3` 
    wait 5
    //live
    // determine activity count
    numberofA = count("(//div[@class='activity-label editor-mode'])")
    echo numberofA is `numberofA`
    for m from 1 to numberofA
        click (//div[@class='activity-label editor-mode'])[`m`]
        // check all (//*[name()='svg'][@name='Settings24'])[1] for tags
        wait 3
        // determine settings count
        numberofS = count ("(//*[name()='svg'][@name='Settings24'])")
        echo numberofS is `numberofS`
        // skip first Setting24 as it is the lesson
        start = 1
        for k from start to numberofS
            wait 3
            if present("(//*[name()='svg'][@name='Settings24'])[`k`]")
                click (//*[name()='svg'][@name='Settings24'])[`k`]
                wait 1
                //live
                if present("//input[@placeholder='Add descriptive tags for others to find it']") or present("//div[@class='bx--text-input__field-wrapper']//input[@class='bx--text-input']")
                    // determine existing keywordtag count
                    numberofT = count("(//span[@title='Clear filter']//span[contains(text(),'')])")
                    for i from 1 to numberofT
                        // reverse the order of clicks to avoid deleting count of keywordtag
                        js j = numberofT + 1 - i
                        read (//span[@title='Clear filter']//span[contains(text(),'')])[`j`] to element
                        echo `j` is `element`
                        // hoping javascript can lower the case to be compared.
                        //live
                        js elementLowerCase = element.toLowerCase()
                        // first p4 to p7 are not case sensitive to catch different variations of string to have a limit of 4 "or"
                        if elementLowerCase contains '`p4`' or elementLowerCase contains '`p5`' or elementLowerCase contains '`p6`' or elementLowerCase contains '`p7`'
                            echo found j = `j`
                            click (//button[@aria-label='Clear filter'])[`j`]
                        // last p8 to p9 contains G1 science  string
                        if element contains '`p8`' or element contains '`p9`' 
                            echo found2 j = `j`
                            click (//button[@aria-label='Clear filter'])[`j`]
                        // last p10 to p11 for exact match
                        if element equals to '`p10`' or element equals to '`p11`' 
                            echo found2 j = `j`
                            click (//button[@aria-label='Clear filter'])[`j`]
                    //add blindly for modular and ease of scalability
                    type bx--text-input as `add1`
                    click (//*[name()='svg'][@name='Save24'])[1]
                    type bx--text-input as `add2`
                    // button is not visible yet, need to wait
                    wait 2
                    //live
                    click (//*[name()='svg'][@name='Save24'])[1]
                // if not found
                wait 1
                click (//*[name()='svg'][@name='Close24'])
                // continue to search for more Setting24

    // active the publish button
    https://`temp` 
    click Approve32
    //live
    click //span[normalize-space()='OK']
    
    // close tab
    dom window.close()
    } 