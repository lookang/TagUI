// type tagui deleteByCSV.tag scienceNT2024_LSSSLSlessonstodelete.csv
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

//live
// if module is unpublished, need to click to go to draft
if present("Pen32")
    click Pen32
    click CheckmarkCircle32

click Kebab24
click //li[@class='delete moe-library']//a[@class='cv-link bx--link']
click OK

