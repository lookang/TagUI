// how to run
// first p1 is part of the url that forms the id of the lesson, expecting 1aff6f7f-5deb-41e3-8389-afc856c5a1fb/cover
// p2 is 3 for third content syllabus to add, expect 1 , 2 or 3 depending on which content map to add, usually is 1 assuming new lesson
// p3 is level of content map, expecting Secondary_2_Express with _ added
// p4 is subject, expecting 21st_Century_Competencies_-_21CC with _ added
// p5 is the URL id of the progressive quiz page, expecting   1aff6f7f-5deb-41e3-8389-afc856c5a1fb/page/46993472
// tagui tagSemiContentMapLesson.tag 1aff6f7f-5deb-41e3-8389-afc856c5a1fb/cover 3 Secondary_2_Express 21st_Century_Competencies_-_21CC 1aff6f7f-5deb-41e3-8389-afc856c5a1fb/page/46993472
// work best on a computer that auto fill password to SLS, will need some configuration for manual key in passwords machines

echo p1 is `p1`
echo p2 is `p2`
echo p3 is `p3`
echo p4 is `p4`
echo p5 is `p5`
// js p1 = p1.replace(/_/gi," " )
// js p2 = p2.replace(/_/gi," ")
js p3 = p3.replace(/_/gi," ")
js p4 = p4.replace(/_/gi," ")
echo new p1 is `p1`
echo new p2 is `p2`
echo new p3 is `p3`
echo new p4 is `p4`
echo new p5 is `p5`
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
https://vle.learning.moe.edu.sg/class-group/lesson/edit/`p1`

// 3 dots
// unused after adding edit to URL above
//click Kebab24
//click Edit

//gear of lesson
click (//*[name()='svg'][@name='Settings24'])[1]
click //button[normalize-space()='Add Lesson Tag']

//subject
if present("(//input[@placeholder='Select Subject'])[`p2`]")
    click (//input[@placeholder='Select Subject'])[`p2`]
    click (//div[@title='`p4`'][normalize-space()='`p4`'])[`p2`]
wait 1
//level
if present("(//input[@placeholder='Select Level'])[`p2`]")
    click (//input[@placeholder='Select Level'])[`p2`]
    //click //input[@title='Select Level']
    // secondary 2 express
    click (//div[@class='bx--list-box__menu-item__option'][normalize-space()='`p3`'])[`p2`]

//save 
click (//*[name()='svg'][@name='Save24'])[1]
//close
click (//*[name()='svg'][@name='Close24'])[1]
//loop
//click //button[normalize-space()='1']
//live
//click /html[1]/body[1]/div[1]/main[1]/div[1]/div[1]/div[1]/section[2]/div[1]/div[1]/div[1]/div[1]/div[2]/div[1]/div[2]/button[1]/*[name()='svg'][1]/*[name()='path'][1]

//loop
//ask what is the number of content map to add on to? expect 1 for First Content Map?  
//echo `ask_result`
//live
start = 1
end = 40
for n from start to end
    https://vle.learning.moe.edu.sg/class-group/lesson/edit/`p5`
    
    // because of the way the xpath is constructed, there is an offset of 2
    offSet = 2
    echo n =`n`
    i = n + offSet
    
    // gear for the first box to add content map tag
    click /html[1]/body[1]/div[1]/main[1]/div[1]/div[1]/div[1]/section[2]/div[1]/div[1]/div[1]/div[`i`]/div[2]/div[1]/div[2]/button[1]/*[name()='svg'][1]/*[name()='path'][1]
    //click /html[1]/body[1]/div[1]/main[1]/div[1]/div[1]/div[1]/section[2]/div[1]/div[1]/div[1]/div[4]/div[2]/div[1]/div[2]/button[1]/*[name()='svg'][1]/*[name()='path'][1]

    wait 3
    //live
    click //button[normalize-space()='Add Question Tag']
    wait 3
    if present("(//input[@placeholder='Select Subject'])[`p2`]")
        click (//input[@placeholder='Select Subject'])[`p2`]
    click (//div[@title='`p4`'][normalize-space()='`p4`'])[`p2`]
    click (//input[@placeholder='Select Level'])[`p2`]
    click (//div[@class='bx--list-box__menu-item__option'][normalize-space()='`p3`'])[`p2`]
    click (//*[name()='svg'][@name='Save24'])[1]
    click (//*[name()='svg'][@name='Close24'])[1]
    // live