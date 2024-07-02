// to run type
// tagui PhysicsLessonContentMapTag.tag crawldatabasebiology.csv
// Echoing variables
echo `i`
echo `title`
echo `link`
echo `status`

//live

//js chatGPTURLshorten = chatGPTURL.substring(8)
//chatGPTURLshorten = 
echo current iteration: `iteration`
if iteration equals to 1
    // Navigate to the SLS login page
    https://vle.learning.moe.edu.sg/login
    wait 5

    //live
    wait 3
    click //button[normalize-space()='Login With SLS']
    type bx--text-input as [clear]MOE-ID 

    click //input[@placeholder='SLS Password'] 
    type //input[@placeholder='SLS Password'] as [clear]PASSWORD

    click //button[normalize-space()='Login']

// do rest of the steps for every iteration
wait 3
//`partofURL`
// https://vle.learning.moe.edu.sg/class-group/lesson/view/1aff6f7f-5deb-41e3-8389-afc856c5a1fb/page/46993472
// https://vle.learning.moe.edu.sg/class-group/lesson/edit/`partofURL`

// Visit the URLs
fulleditableURLsubstring = link.substring(8)
https://`fulleditableURLsubstring`
// Loop through progressive quiz questions to add content maps
//live

click (//*[name()='svg'][@name='Unpublish32'])[1]
click //span[normalize-space()='OK']

click (//a[@tag='component'][normalize-space()='Open'])[1]
popup lesson/view/
    {
    //live
    // pen to edit
    click (//*[name()='svg'][@name='Pen32'])[1]
    // gear
    click //div[@class='card-actions']

    click //button[normalize-space()='Add Lesson Tag']
    numberOfExistingLessonTags = count("//li[@class='cv-accordion-item bx--accordion__item resource-tagging-edit-item']")
    echo `numberOfExistingLessonTags`
    //js numberStartTag = Number(`numberOfExistingLessonTags` + 1)
    js numberStartTag = Number(numberOfExistingLessonTags) + 1;

    //live
    // non intelligent click H1 and stop
    click (//input[@placeholder='Select Subject'])[`numberStartTag`]
    click (//div[@title='Biology - H1BIO'])[`numberStartTag`]
    

    click (//input[@placeholder='Select Level'])[`numberStartTag`] 
    click (//div[@title='Pre-U 1'][normalize-space()='Pre-U 1'])[`numberStartTag`]

    

    live
    echo stop here for human read H1,H2,H3 too complex (high effort) to automate as rule, type done to continue


    click //button[normalize-space()='Add Lesson Tag']

    click (//*[name()='svg'][@name='Save24'])[1]
    
    click (//*[name()='svg'][@name='CheckmarkCircle32'])[1]
    click (//*[name()='svg'][@name='Approve32'])[1]
    click //span[normalize-space()='OK']

    dom window.close()
        }




//click (//*[name()='svg'][@name='Save24'])[1]
//wait 2
//click (//*[name()='svg'][@name='Close24'])[1]
