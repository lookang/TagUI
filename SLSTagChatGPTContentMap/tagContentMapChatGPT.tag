// Define parameters in data.csv
// data.csv is defined same as partofURL,...URLofQuiz
// first partofURL is part of the url that forms the id of the lesson, expecting 1aff6f7f-5deb-41e3-8389-afc856c5a1fb/cover
// contentMapOrder is 3 for third content syllabus to add, expect 1 , 2 or 3 depending on which content map to add, usually is 1 assuming new lesson
// level is level of content map, expecting Secondary_2_Express with _ added
// subject is subject, expecting 21st_Century_Competencies_-_21CC with _ added
// URLofQuiz is the URL id of the progressive quiz page, expecting   1aff6f7f-5deb-41e3-8389-afc856c5a1fb/page/46993472

// How to Run in Command Line tool, type this inside command line
// tagui tagSemiContentMapChatGPT.tag data.csv

//Assumptions
// work best on a computer that auto fill password to SLS, will need some configuration for manual key in passwords machines
// this is a first level tagging, it doesnt have the ability to do intelligent content map tagging yet
// SLS content map checkbox is not static numbering, as other LO are checked, the numbers run referencing the desired LO is impossible to check correctly

// KIV
// seems to be unable to check on the correct checkbox if there are exisiting checkbox, current version can check on a new conent map question tag
// with https://chat.openai.com/ the answer integer may be not the best fit compared to an expert teacher.

// Echoing variables
echo partofURL is `partofURL`
echo contentMapOrder is `contentMapOrder`
echo level is `level`
echo subject is `subject`
echo URLofQuiz is `URLofQuiz`
echo p6 is `p6`
echo p7 is `p7`

echo current iteration: `iteration`
if iteration equals to 1
    // Navigate to the SLS login page
    https://vle.learning.moe.edu.sg/login
    wait 3

    //live

    //ask 1 for SLS 2 for MIMS login
    ask_result = 1 
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
//`partofURL`
// https://vle.learning.moe.edu.sg/class-group/lesson/view/1aff6f7f-5deb-41e3-8389-afc856c5a1fb/page/46993472
// https://vle.learning.moe.edu.sg/class-group/lesson/edit/`partofURL`
// Visit the URLs
https://vle.learning.moe.edu.sg/class-group/lesson/edit/`URLofQuiz`
// Loop through progressive quiz questions to add content maps
start = 8
end = 40


for n from start to end


    click (//button[normalize-space()='`n`'])
    wait 3
    
    read //div[@class='output-text mce-content rich-text-content loaded primary-truncation'] to questionText
    echo questionText `questionText`
    if present("//div[@class='output-text mce-content rich-text-content loaded secondary-truncation']")
        read //div[@class='output-text mce-content rich-text-content loaded secondary-truncation'] to suggestedAnswer
        echo suggestedAnswer `suggestedAnswer`
    if present("//dl[@class='field-set answer-list']//div[@class='answer']")
        read //dl[@class='field-set answer-list']//div[@class='answer'] to correctAnswer
        echo correctAnswer `correctAnswer`

    //GPT
    dom window.open('https://chat.openai.com/') 
        popup chat.openai
            click //div[contains(text(),'PRE-U PHYSICS (H2) (2016).csv')]
            //live
            wait 1
            click //*[@id="prompt-textarea"]
            type //*[@id="prompt-textarea"] as Question to determine the best learning objective number is '`questionText`'.[enter]   I expecting the answer to be a integer number only.
            // type //*[@id="prompt-textarea"] as Question is '`questionText`'. Suggested Answer is '`suggestedAnswer`'. [enter]   I expecting the answer to be a integer number only.
            click //button[@data-testid='send-button']
            wait 3
            chatGPTAnswer = count("(//div[@class='markdown prose w-full break-words dark:prose-invert light'])")
            chatGPTAnswer2 = count("(//div[@data-message-author-role='assistant'])")
            echo chatGPTAnswer is `chatGPTAnswer`
            echo chatGPTAnswer2 is `chatGPTAnswer2`
            wait 3
            read (//div[@class='markdown prose w-full break-words dark:prose-invert light'])[`chatGPTAnswer`] to chatGPTResponse
            read (//div[@data-message-author-role='assistant'])[`chatGPTAnswer2`] to chatGPTResponse2
            echo chatGPTResponse = `chatGPTResponse`
            echo chatGPTResponse2 = `chatGPTResponse2`
            wait 10
            //js checkIfNumber = isNaN(`chatGPTResponse`)
            checkLength = chatGPTResponse.length
            echo checkLength is `checkLength`
            // live
            // assume 0 to 999
            if (checkLength < 4 )
                echo answer is found as an integer, proceeding back to first tab
                dom window.close()
            else
                click //*[@id="prompt-textarea"]
                type //*[@id="prompt-textarea"] as "response should be a number of the learning objective like earlier, in this chat I am only expecting a number to the learning objective"
                click //button[@data-testid='send-button']
                wait 3
                chatGPTAnswer = count("(//div[@class='markdown prose w-full break-words dark:prose-invert light'])")
                
                echo chatGPTAnswerRetry is `chatGPTAnswer`
                wait 3
                read (//div[@class='markdown prose w-full break-words dark:prose-invert light'])[`chatGPTAnswer`] to chatGPTResponse
                echo chatGPTResponse is `chatGPTResponse`
                dom window.close()

            
            


    // popup()
    // because of the way the xpath is constructed, there is an offset of 2
    offSet = 2
    echo n =`n`
    i = n + offSet
    // Click the gear icon to add content map tag
    click /html[1]/body[1]/div[1]/main[1]/div[1]/div[1]/div[1]/section[2]/div[1]/div[1]/div[1]/div[`i`]/div[2]/div[1]/div[2]/button[1]/*[name()='svg'][1]/*[name()='path'][1]
    // live
    click //button[normalize-space()='Copy Tags From Lesson']
    click (//*[name()='svg'][@name='Save24'])[1]


    click //span[contains(text(),'PRE-U PHYSICS (H2) (2016) - 09749')]
    // live
    // level 1
    openArrow = count("(//i[@class='tree-arrow has-child ltr'])")
    for n3 from 1 to openArrow
        m = openArrow - n3 + 1
        click (//i[@class='tree-arrow has-child ltr'])[`m`]
        echo m is `m`
    // level 2
    openArrow2 = count("(//i[@class='tree-arrow has-child ltr'])")
    for n4 from 1 to openArrow2
        m2 = openArrow2 - n4 + 1
        click (//i[@class='tree-arrow has-child ltr'])[`m2`]
    // live
    wait 3
    //checking number in csv is same as SLS content map LOs
    //expecting 236
    numberOfLO = count("(//i[@class='tree-checkbox'])")
    echo numberOfLO is detected as `numberOfLO`

    //load PRE-U PHYSICS (H2) (2016).csv to numberOfLOCSV
    //ask is the number of LO detected = `numberOfLO` same as the PRE-U PHYSICS (H2) (2016).csv? 


    if present("(//i[@class='tree-checkbox'])[`chatGPTResponse`]")
        click (//i[@class='tree-checkbox'])[`chatGPTResponse`]
    else
        echo ChatGPT was unsucessful is providing a number.
    
    ask do you wish to edit the learning objectives? 1 for YES for 60 seconds, 2 for YES for 180 seconds, 3 for YES live, 0 for NO
    if ask_result equals to 1
        wait 60
    else if ask_result equals to 2
        wait 180
    else if ask_result equals to 3
        live
    else if ask_result equals to 0
        wait 0
    else
        wait 0
    
    // Save and close
    click (//*[name()='svg'][@name='Save24'])[1]
    wait 2
    click (//*[name()='svg'][@name='Close24'])[1]