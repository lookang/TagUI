// Specify the TagUI script and the data file to use
// tagui classAddTeachers2.tag data.csv

// --- Login Process ---
//visit URL
if iteration equals to 1
    https://vle.learning.moe.edu.sg/login
    // Wait for the page to load
    wait 3
    // Check if the 'Login With SLS' button is present
    //live
    if present ("//button[normalize-space()='Login With SLS']")
        // Click the 'Login With SLS' button
        click //button[normalize-space()='Login With SLS']
        // Wait after clicking
        wait 3
        // Click the final 'Login' button
        click //button[normalize-space()='Login for Teaching & Learning']
    // Navigate to the class group management page
    https://vle.learning.moe.edu.sg/mrv/class-group
    //iteration = 3
    //echo iteration is `iteration`
    // --- Navigate to Specific Class Group and Add Teacher ---
    // Navigate directly to the specific class group admin page (replace with dynamic navigation if needed)
    // live
    //https://vle.learning.moe.edu.sg/class-group/view/f1633302-ec1f-4a15-b651-89a17adc2f4a?tab=admin
    https://vle.learning.moe.edu.sg/class-group/view/6ccbc90c-5188-44e9-a220-dcc96b6a11fc?tab=admin
    // Click the 'EDIT DETAILS' button
    click //button[normalize-space()='EDIT DETAILS']
    //live

//js iteration = Number(iteration) + 34
//echo iteration after adding 34 is `iteration`
//live




click //ul//h5[contains(text(),'Teachers')]
//click //a[@id='teacher-link']

// Click the 'Add Teacher' button
click //button[normalize-space()='Add Teacher']

click //*[@id="app"]/div[2]/div[2]/div/div[2]/div[1]/div[3]/div[1]/dl/dd/div/div[2]/div/div/div[1]/input
click //div[@title='All Schools']

// Click the input field to find teachers
click //input[@placeholder='Find Teachers']
// Type the teacher's email (from data.csv 'Email' column), clear existing text, and press Enter
type //input[@placeholder='Find Teachers'] as [clear]`Email`[enter]
wait 3
// Click at coordinates (adjust if necessary, might be clicking on the search result)
// 
click (700,250)
wait 2
//live
// ---------- SMART FALLBACK SEARCH (email -> username -> swap domain) ----------
// Detect "no results" by checking if at least 1 selectable checkbox is present.
// If your UI changes, update the xpath below.
if present("(//div[@class='v-selection-control__input'])[2]")
    // found using full email, do nothing
else
    js username = Email.split('@')[0]
    echo No teacher found using email `Email` - trying username `username`
    type //input[@placeholder='Find Teachers'] as [clear]`username`[enter]
    wait 3

    if present("(//div[@class='v-selection-control__input'])[2]")
        // found using username, do nothing
    else
        // try swapping domain between @schools.gov.sg and @moe.edu.sg
        js swapped = '';
        js lowerEmail = Email.toLowerCase();
        if lowerEmail.indexOf('@schools.gov.sg') > -1
            js swapped = username + '@moe.edu.sg';
        else if lowerEmail.indexOf('@moe.edu.sg') > -1
            js swapped = username + '@schools.gov.sg';

        if swapped not equals to ''
            echo No teacher found using username `username` - trying swapped domain `swapped`
            type //input[@placeholder='Find Teachers'] as [clear]`swapped`[enter]
            wait 3

        // If still no results, skip this entry safely (avoid clicking non-existent UI)
        if present("(//div[@class='v-selection-control__input'])[2]")
            // found using swapped email, do nothing
        else
            echo ERROR - cannot find teacher for `Email` (tried email, username, domain swap). Skipping.
            // Optional: take a snapshot for debugging
            // snap page to teacher_not_found_`SerialNo`.png
            continue

// Click at coordinates (adjust if necessary, might be clicking on the search result)
click (700,300)
wait 2

// Click the checkbox for the first teacher found (adjust index if needed)
// click only first name
click (//div[@class='v-selection-control__input'])[2]
wait 2

// Click the button to add the selected teacher(s)
click //button[@class='cv-button bx--btn bx--btn--primary add-selected-btn']
// Click the Save button (using SVG name attribute)
click (//*[name()='svg'][@name='Save24'])[1]
// Click the confirmation 'OK' button
click //button[normalize-space()='OK']
echo SerialNo is `SerialNo`