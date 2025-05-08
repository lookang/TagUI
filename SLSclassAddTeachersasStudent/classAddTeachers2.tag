// Specify the TagUI script and the data file to use
// tagui classAddTeachers.tag data.csv

// --- Login Process ---
//visit URL
if iteration equals to 1
    https://vle.learning.moe.edu.sg/login
    // Wait for the page to load
    wait 3
    // Check if the 'Login With SLS' button is present
    if present ("//button[normalize-space()='Login With SLS']")
        // Click the 'Login With SLS' button
        click //button[normalize-space()='Login With SLS']
        // Wait after clicking
        wait 3
        // Click the final 'Login' button
        click //button[normalize-space()='Login']
    // Navigate to the class group management page
    https://vle.learning.moe.edu.sg/mrv/class-group
    //iteration = 3
    echo iteration is `iteration`
    // --- Navigate to Specific Class Group and Add Teacher ---
    // Navigate directly to the specific class group admin page (replace with dynamic navigation if needed)
    // live
    https://vle.learning.moe.edu.sg/studentgroup/2fb7723f-9be1-4050-b995-bbf23a0dbc71?tab=admin
    // Click the 'EDIT DETAILS' button
    click //button[normalize-space()='EDIT DETAILS']
    //live
echo iteration is `iteration`
click //a[@id='teacher-link']
// Click the 'Add Teacher' button
click //button[normalize-space()='Add Teacher']
// Click the input field to find teachers
click //input[@placeholder='Find Teachers']
// Type the teacher's email (from data.csv 'Email' column), clear existing text, and press Enter
type //input[@placeholder='Find Teachers'] as [clear]`Email`[enter]
// Click at coordinates (adjust if necessary, might be clicking on the search result)
click (700,400)
// Wait for search results or UI update
wait 3
// Click the checkbox for the first teacher found (adjust index if needed)
click (//div[@class='v-selection-control__input'])[1]
// Short wait
wait 1
// Click the button to add the selected teacher(s)
//live
click //button[@class='cv-button bx--btn bx--btn--primary add-selected-btn']
// Click the Save button (using SVG name attribute)
click (//*[name()='svg'][@name='Save24'])[1]
// Click the confirmation 'OK' button
click //button[normalize-space()='OK']
echo SerialNo is `SerialNo`