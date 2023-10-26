// to run on command line
// tagui titlechangefromurl.tag url.csv
// data to prepare is create a xlsx first and export to csv as tagui needs csv to run instead of xlsx
// third column is used with variable name p3 used in the code
//p1	p2	p3
//Forces and Their Effects [LSS] 		https://vle.learning.moe.edu.sg/moe-library/lesson/view/341e6734-7c71-40f6-9a1e-e6ba8dc97fdf/cover
//Friction [LSS]		https://vle.learning.moe.edu.sg/mrv/moe-library/lesson/view/429087ea-4034-4f4e-8ceb-2f6934169760/cover
//Simple Machines [LSS]		https://vle.learning.moe.edu.sg/mrv/moe-library/lesson/view/fcf7150b-39b4-422f-a763-a5de1c950cb6/cover


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

// do rest of the steps for every iteration
wait 3
echo p3 is `p3`
//https://vle.learning.moe.edu.sg/mrv/moe-library/lesson/view/8f68bb0d-a82e-4682-96f2-99a4a3dade6f/cover
//js temp3 = p3.replace("view","edit")

//echo temp3 = `temp3`
// this code if else is to address the issue of url inconsistence some have mrv while some don't 
if p3 contains "mrv"
    js indexPosition = 47
    js temp2 = p3.substring(0,indexPosition) + "/admin" + p3.substring(indexPosition)
    echo temp2 is `temp2`
    //js temp = p3.substring(8)
    js temp = temp2.substring(8)
    echo temp after js substring is `temp`
else
    echo running else
    js indexPosition = 43
    js temp2 = p3.substring(0,indexPosition) + "/admin" + p3.substring(indexPosition)
    echo temp2 is `temp2`
    //js temp = p3.substring(8)
    js temp = temp2.substring(8)
    echo temp after js substring is `temp`

//live
https://`temp` 

//live
read //div[@class='output-text'] to title
// to modify this line to siut different needs for different subject teams
js title = title.replace("[LSS]", "[G1 LSS]");
echo `title`

// first Unpublish
click (//*[name()='svg'][@name='Unpublish32'])
click //span[normalize-space()='OK']
//live

// second open link
click (//a[contains(text(),'Open')])[`1`]
popup lesson/view/
    {
    // in new tab do all the clicks and type
    js temp3 = temp.replace("view","edit")
    https://`temp3` 
    //live
    //click Pen32
    // activate edit mode in SLS
    click output-text
    //click Pencil24
    //click //div[@class='output-text']"(//*[name()='svg'][@name='Pencil24'])[1]
    
    // focus on input field of title
    click bx--text-input
    // clear and type with new title
    type bx--text-input as [clear]`title`

    // click ok
    click CheckmarkCircle32

    // active the publish button
    https://`temp` 
    click Approve32
    //live
    click //span[normalize-space()='OK']
    
    // close tab
    dom window.close()
    } 
//live