// Navigate to the SLS login page
https://vle.learning.moe.edu.sg/login
wait 5

//live
//wait 3
click //button[normalize-space()='Login With SLS']
//type bx--text-input as [clear]MOE-XXXXXX

//click //input[@placeholder='SLS Password'] 
//type //input[@placeholder='SLS Password'] as [clear]PASSWORD

click //button[normalize-space()='Login']
//live

// filter to correct subject and draft 
//https://vle.learning.moe.edu.sg/manage-resource?resource=LESSON&location=MOE&ownerGroups=1126,1121,1174,1163&status=DRAFT&subjects=12790
//
https://vle.learning.moe.edu.sg/manage-resource?resource=LESSON&location=MOE&ownerGroups=1126,1121,1174,1163&status=REJECTED&subjects=12790
wait 5 // ensure new data is read on browser after taking first result again

// does not have graceful handling 20 is just a number for the first page
// to do more pages restart the flow again type delete.tag in cmd
end = 20
for i from 1 to end
 
    click (//a[@tag='component'][normalize-space()='Open'])[`i`]
    popup cover
        {
        click //button[@aria-controls='lesson-submenu']//*[name()='svg']
        click //li[@class='delete moe-library']//a[@class='cv-link bx--link']
        click OK
        dom window.close()
        }
