// type tagui retag.tag scienceNT2024.csv
echo LessonAdminURL as `LessonAdminURL `
echo LessonTitle as `LessonTitle`
echo current iteration: `iteration`
//live
if iteration equals to 1
    // Navigate to the SLS login page
    https://vle.learning.moe.edu.sg/login
    //wait 5

    //live
    //wait 3
    click //button[normalize-space()='Login With SLS']
    wait 1
    ask Key in your SLS Username
    echo  your SLS Username is `ask_result`
    type //input[@placeholder='SLS Username'] as [clear]`ask_result`
    //type bx--text-input as [clear]MOE-XXXXXX
    ask Key in your SLS Password
    echo  your SLS Password is `ask_result`
    click //input[@placeholder='SLS Password'] 
    type //input[@placeholder='SLS Password'] as [clear]`ask_result`

    click //button[normalize-space()='Login for Teaching & Learning']
    

// Visit the URLs
fulleditableURLsubstring = LessonAdminURL.substring(8)
https://`fulleditableURLsubstring`
//live
read (//div[@class='output-text'])[1] to title
echo `title`
//live
//click //button[@type='button']//button[@type='button']//*[name()='svg']//*[name()='path']
if present ("(//*[name()='svg'][@name='Unpublish32'])[1]")
    click (//*[name()='svg'][@name='Unpublish32'])[1]
    //click //div[@class='fetch-data-button button tip-bottom']//button[@role='button']
    click //div[@aria-label='Information modal']//div//div//button[@type='button']
//live
wait 3

//click (//a[@tag='component'][normalize-space()='Open'])[1]
if present ("//a[text()='Open']")
    click //a[text()='Open']
wait 3
popup admin/moe-library/module/view/
    {
    //title
    wait 3
    click (//*[name()='svg'][@name='Pen32'])[1]
    //live
    wait 3
    click //div[@class='output-text']
    wait 3
    click //input[@class='bx--text-input']
    wait 3
    updatedText = LessonTitle.replace(/\[.*?\]/, "[G1]");
    type //input[@class='bx--text-input'] as [clear]`updatedText`
    click (350,150)

    // keyword tags
    //live
    // continue in edit mode
    click (//*[name()='svg'][@name='Settings24'])[1]

    click //div[@class='bx--text-input__field-wrapper'] 
    type //div[@class='bx--text-input__field-wrapper'] as [clear]G1
    keyboard [enter]
    // simulate enter since enter didnt work
    //live
    click (700,250)
    click (//*[name()='svg'][@name='Save24'])[1]
    




    // approval 
    click (//*[name()='svg'][@name='CheckmarkCircle32'])[1]
    wait 3
    click (//*[name()='svg'][@name='Approve32'])[1]
    wait 3
    click OK
    wait 3
    dom window.close()
    }   
