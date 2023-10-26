// Navigate to the SLS login page
https://vle.learning.moe.edu.sg/login
ask_result = 1
//ask 1 for SLS 2 for MIMS login
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
https://vle.learning.moe.edu.sg/manage-resource?resource=LESSON&location=MOE&ownerGroups=ALL&status=ALL&subjects=12790&levels=18,19

wait 2
// getting total_number of rows
if present('//div[@class="v-data-footer__pagination"]')
    read //div[@class="v-data-footer__pagination"] to pagination
    js total = parseInt(pagination.split("of")[1].trim());
    echo There are `total` number of lessons.

tableCnt = 0
// to prepare the page at the correct tableCnt
for m from 1 to tableCnt
    click //button[@aria-label="Next page"]
// change rowCnt when need
rowCnt = 1


for i from 1 to (total-tableCnt*20)

    link = ""

    // click Open link
    click (//a[contains(text(),'Open')])[`rowCnt`]
    live
    popup lesson/view/
        {
        wait 1 
        read //div[@class='output-text'] to title
        js title = title.replace("[LSS]", "[G1 LSS]");

        click (//*[name()='svg'][@name='Unpublish32'])
        click //span[normalize-space()='OK']

        click (//a[contains(text(),'Open')])[`rowCnt`]
        
        popup admin/lesson/view/
            {
            click cv-tooltip bx--tooltip__trigger bx--tooltip--a11y bx--tooltip--bottom bx--tooltip--align-center
            click //div[@class='output-text']"(//*[name()='svg'][@name='Pencil24'])[1]"undefined
            click bx--text-input
            type bx--text-input as [clear]`title`[enter]

            click //div[@class='output-text']"(//*[name()='svg'][@name='CheckmarkCircle32'])
            dom window.close()
            }
        dom window.close()
        }
live