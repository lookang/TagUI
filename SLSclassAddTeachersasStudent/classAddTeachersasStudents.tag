// https://www.youtube.com/shorts/2ECiSIdCV6g 
// Specify the TagUI script and the data file to use
// tagui classAddTeachers.tag data.csv
echo iteration is `iteration`
if iteration equals to 1

    echo SerialNo is `SerialNo`
    echo Email is `Email`
    
    https://vle.learning.moe.edu.sg/login
    click //button[normalize-space()='Login With SLS']
    click //button[normalize-space()='Login for Teaching & Learning']
    echo navigate to classURL
    //live
    https://vle.learning.moe.edu.sg/class-group/view/85813c71-2a74-4b4d-af3e-2b5a43883df3?tab=admin

// Click the 'EDIT DETAILS' button
click //button[normalize-space()='EDIT DETAILS']
//live
echo iteration is `iteration`
// Click the 'Teachers' tab link
//live
// click //a[@id='student-link']
// Click the 'Add Teacher' button
click //span[normalize-space()='Add Student']
click //span[normalize-space()='Teacher as Student']

//  School
click //input[@placeholder='MOE HQ']
click //div[@title='All Schools'] 

// Click the input field to find teachers
click //input[@placeholder='Find Teachers']
// Type the teacher's email (from data.csv 'Email' column), clear existing text, and press Enter
type //input[@placeholder='Find Teachers'] as [clear]`Email`[enter]
// Click at coordinates (adjust if necessary, might be clicking on the search result) strangely TagUI cannot type enter
// to trick SLS to accept the [enter] search, click twice works, but not once
click (200,200)
click (200,200)
// Wait for search results or UI update
wait 10
// Click the checkbox for the first teacher found (adjust index if needed)
//live
click (//div[@class='v-selection-control__input'])[1]
// Short wait
wait 1
// Click the button to add the selected teacher(s)
//live
// click //button[@class='cv-button bx--btn bx--btn--primary add-selected-btn']
click //span[normalize-space()='Add']
// Click the Save button (using SVG name attribute)
click (//*[name()='svg'][@name='Save24'])[1]
// Click the confirmation 'OK' button
//click //button[normalize-space()='OK']
echo SerialNo is `SerialNo`
