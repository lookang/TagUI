// to run on command line
// tagui keywordaddtoallquestionsintelligent.tag url.csv
// data to prepare is create a xlsx first and export to csv as tagui needs csv to run instead of xlsx
// third column is used with variable name p3 used in the code
//p1	p2	p3
//Forces and Their Effects [LSS] 		https://vle.learning.moe.edu.sg/moe-library/lesson/view/341e6734-7c71-40f6-9a1e-e6ba8dc97fdf/cover
//Friction [LSS]		https://vle.learning.moe.edu.sg/mrv/moe-library/lesson/view/429087ea-4034-4f4e-8ceb-2f6934169760/cover
//Simple Machines [LSS]		https://vle.learning.moe.edu.sg/mrv/moe-library/lesson/view/fcf7150b-39b4-422f-a763-a5de1c950cb6/cover

//limitation
// keyword limit could be exhausted that cause error

// Navigate to the SLS login page
https://vle.learning.moe.edu.sg/login
ask_result = 1
//ask 1 for SLS 2 for MIMS login
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

popup lesson/view/
    {
    // in new tab do all the clicks and type
    js temp3 = temp.replace("view","edit")
    https://`temp3` 
    wait 5
    numberofA = count("(//div[@class='activity-label editor-mode'])")
    echo numberofA is `numberofA`
    for m from 1 to numberofA
        click (//div[@class='activity-label editor-mode'])[`m`]
        // check all (//*[name()='svg'][@name='Settings24'])[1] for tags
        wait 3
        numberofS = count ("(//*[name()='svg'][@name='Settings24'])")
        echo numberofS is `numberofS`
        // skip first Setting24 as it is the lesson
        start = 2
        for k from start to numberofS
            wait 3
            if present("(//*[name()='svg'][@name='Settings24'])[`k`]")
                click (//*[name()='svg'][@name='Settings24'])[`k`]
                if present("//input[@placeholder='Add descriptive tags for others to find it']")
                    numberofT = count("(//span[@title='Clear filter']//span[contains(text(),'')])")
                    for i from 1 to numberofT
                        // reverse the order of clicks to avoid deleting count of stuff
                        js j = numberofT + 1 - i
                        read (//span[@title='Clear filter']//span[contains(text(),'')])[`j`] to element
                        echo `j` is `element`
                        // appears to be case sensitive so need more or statements appears to have a limit of 4 "or"
                        if element contains '`p4`' or element contains '`p5`' or element contains '`p6`' or element contains '`p7`'
                            echo found j = `j`
                            click (//button[@aria-label='Clear filter'])[`j`]
                        if element contains '`p8`' or element contains '`p9`' or element contains '`p10`' or element contains '`p11`'
                            echo found j = `j`
                            click (//button[@aria-label='Clear filter'])[`j`]
                    //add blindly
                    type bx--text-input as `add1`
                    click (//*[name()='svg'][@name='Save24'])[1]
                    type bx--text-input as `aad2`
                    // button is not visible yet, need to wait
                    wait 2
                    //live
                    click (//*[name()='svg'][@name='Save24'])[1]
                // if not found
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