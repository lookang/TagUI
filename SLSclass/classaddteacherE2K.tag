// this flow must be done in the primary monitor as it uses computer vision to click the png
// the type didnt work so use png to identify stuff and bring into focus for the keyboard to work
//https://tagui.readthedocs.io/en/latest/reference.html
//tableofemails = [Name list for Pri pilot.xlsx]2021!E3:E100 
// change this based on the xlsx data for ease of reading
//tableofemails = [C2T email addresses.xlsx]C2T email addresses!H82:H95  

tableofemails = [Registration for Critical & Creative Thinking Training Webinars-31 Aug.xlsx]Registration for Critical & Cre!L7:L95 
// change this to suit the xlsx as flow may stop prematurely and restart with the rest of the incomplete data
startrow = 0
echo `tableofemails[startrow]`

//visit URL
https://vle.learning.moe.edu.sg/login
wait 3
click //button[normalize-space()='Login With SLS']
wait 3
click //button[normalize-space()='Login']
https://vle.learning.moe.edu.sg/mrv/class-group

// live


https://vle.learning.moe.edu.sg/studentgroup/b5a48a8e-0f49-4b0a-a9bc-56b5248e56a5?tab=admin
//click VIEW
click //button[normalize-space()='VIEW & EDIT']


// sls limit manually change based on what is the last item on the xlsx
total = 95 - 7

for i from startrow to total 
    click Add Student
    wait 1
    // must have full screen to detect this correctly
    click  Teacher as Student 
    wait 1
    // may not need to change to All Schools if emails are all HQ, just to be safe
    click //input[@placeholder='MOE HQ'] 
    wait 1
    click (//div[@title='All Schools'])[1]

    // focus is on the All Schools, need to click away
    wait 1
    //live

    //live
    vision Settings.AlwaysResize = 0.5
    //click search.png
    if present('searchv2.png')
        click searchv2.png
    if present('findteachers.png')
        click findteachers.png
    else
        live 
        echo resume the flow type done
    wait 2
    echo `tableofemails[i]`
    if  tableofemails[i] equals to ''
        echo 'do nothing'
        //simulate like no user found and click back
        click ArrowLeft24
    else 
        keyboard `tableofemails[i]`[enter] 
        wait 2
        if present ("//td[@class='text-start']//i[@class='v-icon notranslate mdi mdi-checkbox-blank-outline theme--light']")
            click //td[@class='text-start']//i[@class='v-icon notranslate mdi mdi-checkbox-blank-outline theme--light']
            // click //tbody/tr[1]/td[1]/div[1]/i[1]
            click //span[normalize-space()='Add']
            click Save24
            click OK
        else
            click ArrowLeft24