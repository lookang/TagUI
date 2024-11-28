// type tagui retag.tag scienceNT2024.csv
echo LessonAdminURL as `LessonAdminURL `
echo LessonTitle as `LessonTitle`
echo current iteration: `iteration`
if iteration equals to 1
    // Navigate to the SLS login page
    https://vle.learning.moe.edu.sg/login
    wait 5

    //live
    //wait 3
    click //button[normalize-space()='Login With SLS']
    //type bx--text-input as [clear]MOE-XXXXXX

    //click //input[@placeholder='SLS Password'] 
    //type //input[@placeholder='SLS Password'] as [clear]PASSWORD

    click //button[normalize-space()='Login']
    

// Visit the URLs
fulleditableURLsubstring = LessonAdminURL.substring(8)
https://`fulleditableURLsubstring`
//live
read (//div[@class='output-text'])[1] to title
echo `title`

click //button[@type='button']//button[@type='button']//*[name()='svg']//*[name()='path']
click //div[@class='fetch-data-button button tip-bottom']//button[@role='button']
//live
wait 3

click (//a[@tag='component'][normalize-space()='Open'])[1]
wait 3
popup cover
    {
    wait 3
    click (//*[name()='svg'][@name='Pen32'])[1]
    //live
    wait 3
    click //div[@class='output-text']
    wait 3
    click //input[@class='bx--text-input']
    wait 3
    updatedText = LessonTitle.replace(/\[.*?\]/, "[For 2014 USS NT syllabus]");
    type //input[@class='bx--text-input'] as [clear]`updatedText`
    click (//*[name()='svg'][@name='CheckmarkCircle32'])[1]
    wait 3
    click (//*[name()='svg'][@name='Approve32'])[1]
    wait 3
    click OK
    wait 3
    dom window.close()
    }   
