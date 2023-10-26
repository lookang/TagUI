// Navigate to the SLS login page
https://vle.learning.moe.edu.sg/login

ask_result = 1
echo `ask_result`

// Login process
if ask_result equals to 1
    if present('//button[normalize-space()="Login With SLS"]')
        click //button[normalize-space()='Login With SLS']
    if present("//button[normalize-space()='Login']")
        click //button[normalize-space()='Login']
else if ask_result equals to 2
    if present("//button[normalize-space()='Login With MIMS']")
        click //button[normalize-space()='Login With MIMS']
        wait 3
        click (//span[@id='loginButton2'])[1]

wait 3

// Process for each URL in the CSV file
for row from 1 to datatable_count
{
    load `url.csv` to datatable
    echo p3 is `p3`

    // Adjust URL for admin access
    js temp2 = p3.includes("mrv") ? p3.replace("/mrv/moe-library/lesson/view", "/admin/moe-library/lesson/edit") : p3.replace("/moe-library/lesson/view", "/admin/moe-library/lesson/edit")
    echo temp2 is `temp2`

    // Navigate to the lesson page
    https://`temp2` 

    // Read and modify the title
    read //div[@class='output-text'] to title
    js title = title.replace("[LSS]", "[G1 LSS]");
    echo `title`

    // Unpublish the lesson
    click (//*[name()='svg'][@name='Unpublish32'])
    click //span[normalize-space()='OK']

    // Open the lesson in a new tab for editing
    popup lesson/view/
    {
        https://`temp2` 
        click output-text

        // Edit the title
        click bx--text-input
        type bx--text-input as [clear]`title`
        click CheckmarkCircle32

        // Publish the lesson with the new title
        https://`temp2` 
        click Approve32
        click //span[normalize-space()='OK']

        dom window.close()
    } 
}
