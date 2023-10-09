// how to run
// first p1 is the url id of the lesson
// p2 is 3 for thrid content syllabus to add
//p3 is level of content map
//p4 is subject
//tagui tagSemiContentMap.tag 1aff6f7f-5deb-41e3-8389-afc856c5a1fb/page/46993472 3 Secondary_2_Express 21st_Century_Competencies_-_21CC
echo p1 is `p1`
echo p2 is `p2`
echo p3 is `p3`
echo p4 is `p4`
js p1 = p1.replace(/_/gi," " )
js p2 = p2.replace(/_/gi," ")
js p3 = p3.replace(/_/gi," ")
js p4 = p4.replace(/_/gi," ")
echo new p1 is `p1`
echo new p2 is `p2`
echo new p3 is `p3`
echo new p4 is `p4`
//live
// ask navigate to SLS, login and go to the page for content map tagging for example https://vle.learning.moe.edu.sg/class-group/lesson/view/1aff6f7f-5deb-41e3-8389-afc856c5a1fb/page/46993472 make sure it is on the first tab, and type "done" when done
// live
//visit URL
https://vle.learning.moe.edu.sg/login
wait 3
if present('//button[normalize-space()="Login With SLS"]')
    click //button[normalize-space()='Login With SLS']
wait 3
if present("//button[normalize-space()='Login']")
    click //button[normalize-space()='Login']

// edit this line below to the URL of content map tagging
// this is a first level tagging, it doesnt have the ability to do intelligent content map tagging
wait 3
//`p1`
// https://vle.learning.moe.edu.sg/class-group/lesson/view/1aff6f7f-5deb-41e3-8389-afc856c5a1fb/page/46993472
https://vle.learning.moe.edu.sg/class-group/lesson/view/`p1`

// 3 dots
click Kebab24
click Edit

//loop
//click //button[normalize-space()='1']
//live
//click /html[1]/body[1]/div[1]/main[1]/div[1]/div[1]/div[1]/section[2]/div[1]/div[1]/div[1]/div[1]/div[2]/div[1]/div[2]/button[1]/*[name()='svg'][1]/*[name()='path'][1]

//loop
//ask what is the number of content map to add on to? expect 1 for First Content Map?  
//echo `ask_result`

for n from 1 to 40
    offSet = 2
    i = n + offSet
    // gear for the first box to add content map tag
    click /html[1]/body[1]/div[1]/main[1]/div[1]/div[1]/div[1]/section[2]/div[1]/div[1]/div[1]/div[`i`]/div[2]/div[1]/div[2]/button[1]/*[name()='svg'][1]/*[name()='path'][1]
    //click /html[1]/body[1]/div[1]/main[1]/div[1]/div[1]/div[1]/section[2]/div[1]/div[1]/div[1]/div[4]/div[2]/div[1]/div[2]/button[1]/*[name()='svg'][1]/*[name()='path'][1]

    wait 3
    //live
    click //button[normalize-space()='Add Question Tag']
    wait 3
    //live
    //ask what is the number of content map to add on to? expect 1 for First Content Map?  
    //echo `ask_result`
        if present("(//input[@placeholder='Select Subject'])[`p2`]")
            click (//input[@placeholder='Select Subject'])[`p2`]
    //if present("(//input[@placeholder='Select Subject'])[`ask_result`]")
    //click (//input[@placeholder='Select Subject'])[`ask_result`]

    //else if present("(//input[@placeholder='Select Subject'])[2]")
    //    click (//input[@placeholder='Select Subject'])[2]
    //else if present("(//input[@placeholder='Select Subject'])[3]")
    //    click (//input[@placeholder='Select Subject'])[3]
    //else if present("(//input[@placeholder='Select Subject'])[4]")
    //    click (//input[@placeholder='Select Subject'])[4]
    // click (//input[@placeholder='Select Subject'])[4]

    //live 
    echo need to key here the subject, expect 21st Century Competencies - 21CC
    subjectName = "21st Century Competencies - 21CC"

    // click (//div[@title='21st Century Competencies - 21CC'][normalize-space()='21st Century Competencies - 21CC'])[`ask_result`]
    click (//div[@title='`p4`'][normalize-space()='`p4`'])[`p2`]
    //click (//div[@title='`subjectName`'][normalize-space()='`subjectName`'])[`p2`]
    //click (//div[@title='`subjectName`'][normalize-space()='`subjectName`'])[`ask_result`]

    click //input[@title='Select Level']

    echo what is the Level, expecting Secondary 2 Express
    levelName = "Secondary 2 Express"
    //live
    // need to find the third from `ask_result` content map, to identify the third  levelName
    click (//div[@class='bx--list-box__menu-item__option'][normalize-space()='`p3`'])[`p2`]
    //click (//div[@class='bx--list-box__menu-item__option'][normalize-space()='`levelName`'])[`p2`]
    //click (//div[@class='bx--list-box__menu-item__option'][normalize-space()='`levelName`'])[`ask_result`]
    //click //div[@class='bx--list-box__menu-item bx--list-box__menu-item--highlighted']//div[contains(text(),'Secondary 2 Express')]
    //click //div[@class='bx--list-box__menu-item bx--list-box__menu-item--highlighted']//div[@class='bx--list-box__menu-item__option'][normalize-space()='`levelName`']
    //click //div[@class='bx--list-box__menu-item bx--list-box__menu-item--highlighted']//div[@class='bx--list-box__menu-item__option'][normalize-space()='Primary 2']


    click (//*[name()='svg'][@name='Save24'])[1]
    click (//*[name()='svg'][@name='Close24'])[1]
    // live