// assume self login to SLS
//live
https://vle.learning.moe.edu.sg/
if exist ('Login With SLS')
    click //button[normalize-space()='Login With SLS']
    click //button[normalize-space()='Login']
// https://vle.learning.moe.edu.sg/manage-resource?keyword=&location=MOE&resource=LESSON&ownerGroups=1121,1174,1163&status=ALL
// https://vle.learning.moe.edu.sg/notification
for n from 1 to 20
    https://vle.learning.moe.edu.sg/notification
    echo counter n = `n`
    //wait 1
    //live
    //click (//*[name()='svg'][@name='Bell32'])[1]
    wait 2
    click (//*[name()='svg'][@name='Download32'])[`n`]
    // click (//b[contains(text(),'SLS')])[`n`]
    // click (//*[name()='svg'][@name='Download32'])[`n`]
live
