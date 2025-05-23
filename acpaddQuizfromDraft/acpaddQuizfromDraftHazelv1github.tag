//======================================================
//  SLS VLE Script
//  ----------------------------------------------------
//  Purpose: Automate resource management and quiz creation
// features: does not copy paste automatically, skip login if login in already, ask user for start of module
//  Author:  [lawrence_wee@moe.gov.sg]
//  Date:    [20250116]
//======================================================

//------------------------------------------------------
// STEP 1 - OPEN SLS AND LOGIN
//------------------------------------------------------
https://vle.learning.moe.edu.sg/login
wait 5

//js chatGPTURLshorten = chatGPTURL.substring(8)
//chatGPTURLshorten = 
//echo current iteration: `iteration`

// Navigate to the SLS login page
https://vle.learning.moe.edu.sg/login
//wait 5

//live
wait 3
if present("//button[normalize-space()='Login With SLS']")
    click //button[normalize-space()='Login With SLS']
    type bx--text-input as [clear]MOE-00000A 
    click //input[@placeholder='SLS Password'] 
    type //input[@placeholder='SLS Password'] as [clear]putyourown
    click //button[normalize-space()='Login']

// do rest of the steps for every iteration

wait 3
//------------------------------------------------------
// STEP 2 - NAVIGATE TO MANAGE RESOURCE PAGE
//------------------------------------------------------
// Access the "Manage Resource" page, filtered to show only draft/unpublished lessons for subject=611.
//browsing
//https://vle.learning.moe.edu.sg/search?location=MOE&keyword=&resource=LESSON&resourceType=&subject=611&level=&syllabus&parentTopic=&topic=&learningOutcome=&area=
//https://vle.learning.moe.edu.sg/manage-resource?resource=LESSON&location=MOE&ownerGroups=1126,1121,1174,1163&status=ALL&subjects=611
//https://vle.learning.moe.edu.sg/manage-resource?resource=LESSON&location=MOE&ownerGroups=1126,1121,1174,1163&status=DRAFT,UNPUBLISHED&subjects=611
https://vle.learning.moe.edu.sg/manage-resource?resource=LESSON&location=MOE&ownerGroups=1126,1121,1174,1163&status=DRAFT,UNPUBLISHED&subjects=506
echo navigate to your status=DRAFT,UNPUBLISHED MOE modules to start adding Quiz
//live

wait 3
// Navigate and process modules from index 15 to 20

//------------------------------------------------------
// STEP 3 - DEFINE LOOP AND PROCESS MODULES
//------------------------------------------------------
ask start from which module? expecting 1 to 20
echo ask result is `ask_result`

//start = 2
start = ask_result
n = start
end = 20
for n from start to end
    echo n is `n` 
    //click (//a[@class='cv-link bx--link'][normalize-space()='Open'])[`n`]
    //click (//a[@tag='component'][normalize-space()='Open'])[`n`]

    // into module from Manage Modules page
    click //*[@id="main-content"]/div/div/section/div/div[2]/div[2]/div/div[1]/table/tbody/tr[`n`]/td[1]/div/div/a
    
    popup cover

        // check if quiz exists, if yes, quit.
        //==================================================
        // 3.1 CHECK IF QUIZ ALREADY EXISTS
        //==================================================
        wait 3
        numberOfQuiz = count ("(//*[name()='svg'][@name='QuizPage32'])")
        echo numberOfQuiz is `numberOfQuiz`
        if numberOfQuiz > 0
            echo note the module already has a Quiz, 
            //break

        dom window.close()



    // into module from Manage Modules page
    //==================================================
    // 3.2 VIEW KNOWLEDGE BASE (PRINT-FRIENDLY WORKSHEET)
    //==================================================
    wait 3
    click //*[@id="main-content"]/div/div/section/div/div[2]/div[2]/div/div[1]/table/tbody/tr[`n`]/td[1]/div/div/a
    
    popup cover

        // get knowledge base printout text
        wait 3
        click Kebab24
        wait 3
        click View as Print-Friendly Worksheet
        
        dom window.close()

    //==================================================
    // 3.3 COPY CONTENT FROM PRINT VIEW
    //==================================================
    popup printview

        //click (500,500)
        wait 6
        echo do your own keyboard ctrl a and ctrl c
        live

        //keyboard [ctrl]a
        //keyboard [ctrl]c
        //result =  clipboard()
        //echo result is `result`
        
        
        
        dom window.close()


    // into module from Manage Modules page
    //==================================================
    // 3.4 ADD A NEW QUIZ TO THE MODULE
    //==================================================
    wait 3
    click //*[@id="main-content"]/div/div/section/div/div[2]/div[2]/div/div[1]/table/tbody/tr[`n`]/td[1]/div/div/a
    popup cover 

        
        click Pen32
        

        numberOfPages = count ("(//*[name()='svg'][@name='Page32'])")
        echo numberOfPages is `numberOfPages`
        click (//*[name()='svg'][@name='Page32'])[`numberOfPages`]

        click Plus24
        wait 2
        click Plus24

        
        echo check quiz 
        wait 2
        click //p[normalize-space()='Quiz']
        wait 2

        //click //div[@class='bx--text-input__field-wrapper']
        //type //div[@class='bx--text-input__field-wrapper']//input as [clear]Quiz

        

        click (//*[name()='svg'][@name='ACPGenerate24'])[2]
        wait 3
        type bx--text-input as [clear]Quiz
        wait 1
        type bx--text-area as Create 5 multiple-choice questions (MCQs), each with 4 options and only one correct answer. The questions should assess knowledge with understanding and application of information. Additionally, include 2 short-answer questions inspired by real-life applications to spark joy in learning. For open-ended short-answer questions, add the note "(1 mark): accept any other reasonable answers" if applicable..  
        echo (1 mark): accept any other reasonable answers
        
        if present("Add Knowledge Base")
            click Add Knowledge Base
            wait 3
            //click (700,700)
            wait 3
            echo do your own ctrl v 
            live
            
            
        
            click //span[normalize-space()='Add']
        

            click Kebab24
        





        if present("ACPGenerate32")
            click ACPGenerate32
            wait 30
            echo type done to continue
            live
            
            // + ADD button
            if present("//span[normalize-space()='Add']")
                click //span[normalize-space()='Add']
                //fetch-data-button button tip-top tip-end btn-add
        wait 3
        
        click CheckmarkCircle32

        // add Learing progress inclusion
        //==================================================
        // 3.5 ADD LEARNING PROGRESS
        //==================================================
        click Pen32
        // second setting
        click (//*[name()='svg'][@name='Settings24'])[2]
        click //span[normalize-space()='Apply to all questions']
        click //span[normalize-space()='Include in Learning Progress']
        click //button[normalize-space()='Ok']
        click Close24
        click CheckmarkCircle32

        // check by human
        //==================================================
        // 3.6 APPROVAL PROCESS
        //==================================================
        echo check the questions and make edits. when ready to continue, type done.
        live

        wait 3
        //click Approve32
        //click OK
        // need to wait for approval
        //wait 10
        dom window.close()




    

        
