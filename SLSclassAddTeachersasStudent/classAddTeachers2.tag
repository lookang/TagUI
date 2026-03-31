// Specify the TagUI script and the data file to use
// tagui classAddTeachers2.tag data.csv

// --- Login Process ---
//visit URL
if iteration equals to 1
    https://vle.learning.moe.edu.sg/login
    // Wait for the page to load
    wait 3
    // Check if the 'Login With SLS' button is present
    echo login yourself
    live
    
    // Navigate to the class group management page
    https://vle.learning.moe.edu.sg/mrv/class-group
    //iteration = 3
    //echo iteration is `iteration`
    // --- Navigate to Specific Class Group and Add Teacher ---
    // Navigate directly to the specific class group admin page (replace with dynamic navigation if needed)
    // live
    //https://vle.learning.moe.edu.sg/class-group/view/f1633302-ec1f-4a15-b651-89a17adc2f4a?tab=admin
    //https://vle.learning.moe.edu.sg/class-group/view/6ccbc90c-5188-44e9-a220-dcc96b6a11fc?tab=admin
    //https://vle.learning.moe.edu.sg/class-group/view/886de9e9-f4ab-4959-886f-042f889320d6?tab=admin
    ask for the class URL
    js class_url = ask_result.trim().replace(/^https?:\/\//,'')
    https://`class_url`
    // https://vle.learning.moe.edu.sg/class-group/view/886de9e9-f4ab-4959-886f-042f889320d6?tab=admin 
    // Click the 'EDIT DETAILS' button
    click //button[normalize-space()='EDIT DETAILS']
    // Initialize failed emails CSV
    dump SerialNo,Email,Timestamp to failed_emails.csv
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

// Auto-detect the correct SerialNo and Email columns from the current CSV row
js begin
function get_var(name) {
    try {return eval(name);} catch(e) {return '';}
}
function looks_like_email(value) {
    return (typeof value === 'string') && /^[^\s@]+@[^\s@]+\.[^\s@]+$/i.test(value.trim());
}
var serial_candidates = ['SerialNo','Serial_No','Serial','No','No_','Row','RowNo','Row_No','ID','Id'];
var email_candidates = ['Email','Email_','email','EMAIL','EmailAddress','Email_Address','Email_address','StaffEmail','Staff_Email','TeacherEmail','Teacher_Email','WorkEmail','Work_Email','OfficialEmail','Official_Email','ContactEmail','Contact_Email','MOE_Email','SLS_Email','E_mail','Mail'];
var detected_serial = '';
var detected_email = '';
email_source = '';

for (var i = 0; i < serial_candidates.length; i++) {
    var s = get_var(serial_candidates[i]);
    if (s !== '' && s != null) {detected_serial = ('' + s).trim(); break;}
}

for (var j = 0; j < email_candidates.length; j++) {
    var candidate = get_var(email_candidates[j]);
    if (looks_like_email(candidate)) {
        detected_email = candidate.trim().toLowerCase();
        email_source = email_candidates[j];
        break;
    }
}

if (!detected_email) {
    var root = Function('return this')();
    Object.keys(root).some(function(key) {
        var value = root[key];
        if (!looks_like_email(value)) return false;
        detected_email = value.trim().toLowerCase();
        email_source = key;
        return true;
    });
}

SerialNo = detected_serial || iteration;
Email = detected_email;
js finish

if Email equals to ''
    echo ERROR - cannot detect an email column for row `SerialNo`. Skipping.
    js now_sg = new Date(Date.now() + 8 * 60 * 60 * 1000)
    sg_time = now_sg.getUTCFullYear() + '-' + ('0' + (now_sg.getUTCMonth() + 1)).slice(-2) + '-' + ('0' + now_sg.getUTCDate()).slice(-2) + ' ' + ('0' + now_sg.getUTCHours()).slice(-2) + ':' + ('0' + now_sg.getUTCMinutes()).slice(-2) + ':' + ('0' + now_sg.getUTCSeconds()).slice(-2) + ' GMT+8'
    write `csv_row([SerialNo, '[email not detected]', sg_time])` to failed_emails.csv
    continue

echo Using email from `email_source` -> `Email`

// Click the input field to find teachers
click //input[@placeholder='Find Teachers']
// Type the teacher's email from the auto-detected CSV column, clear existing text, and press Enter
type //input[@placeholder='Find Teachers'] as [clear]`Email`[enter]
wait 3
// Click at coordinates (adjust if necessary, might be clicking on the search result)
// 
click (700,250)
wait 2
//live
// ---------- SMART FALLBACK SEARCH (email -> alternate email -> name) ----------
// Detect "no results" by checking if at least 1 selectable checkbox is present.
// If your UI changes, update the xpath below.
if present("(//div[@class='v-selection-control__input'])[2]")
    // found using full email, do nothing
else
    js username = Email.split('@')[0]
    // try swapping domain between @schools.gov.sg and @moe.edu.sg
    js swapped = '';
    js lowerEmail = Email.toLowerCase();
    if lowerEmail.indexOf('@schools.gov.sg') > -1
        js swapped = username + '@moe.edu.sg';
    else if lowerEmail.indexOf('@moe.edu.sg') > -1
        js swapped = username + '@schools.gov.sg';

    if swapped not equals to ''
        echo No teacher found using email `Email` - trying alternate email `swapped`
        type //input[@placeholder='Find Teachers'] as [clear]`swapped`[enter]
        // need a trigger to allow search to happen
        click (700,250)
        wait 3

    if present("(//div[@class='v-selection-control__input'])[2]")
        // found using alternate email, do nothing
    else
        // final fallback: search by name (remove underscores from email local-part)
        js name_only = username.replace(/_/g, ' ');
        echo No teacher found using alternate email `swapped` - trying name `name_only`
        type //input[@placeholder='Find Teachers'] as [clear]`name_only`[enter]
        // need a trigger to allow search to happen
        click (700,250)
        wait 3

        // If still no results, skip this entry safely (avoid clicking non-existent UI)
        if present("(//div[@class='v-selection-control__input'])[2]")
            // found using name, do nothing
        else
            echo ERROR - cannot find teacher for `Email` (tried email, alternate email, name). Skipping.
            // Record failed email with SerialNo and Singapore timestamp
            js now_sg = new Date(Date.now() + 8 * 60 * 60 * 1000)
            sg_time = now_sg.getUTCFullYear() + '-' + ('0' + (now_sg.getUTCMonth() + 1)).slice(-2) + '-' + ('0' + now_sg.getUTCDate()).slice(-2) + ' ' + ('0' + now_sg.getUTCHours()).slice(-2) + ':' + ('0' + now_sg.getUTCMinutes()).slice(-2) + ':' + ('0' + now_sg.getUTCSeconds()).slice(-2) + ' GMT+8'
            write `csv_row([SerialNo, Email, sg_time])` to failed_emails.csv
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