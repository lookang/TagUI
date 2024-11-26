O Search
L
£
昭
8
= delete.tag X
Users › lookang › Desktop › tagui › flows › pohYin ›
// Navigate to the SLS login page
https://vle.learning.moe.edu.sg/login
wait 5
12
14
15
17
18
24
25
26
27
= delete.tag
//live //wait • 3
click //button [normalize-space()='Login With SLS'] //type-bx—-text-input-as • [clear] MOE-XXXXXX
//click•//input [@placeholder='SLS Password']
//type • // input [@placeholder='SLS Password'] -as • [clear] PASSWORD
click //button [normalize-space()= 'Login']
//Live
//• filter to correct subject and draft.
//https://vle.learning-moe.edu.sg/manage-resource?resource=LESSON&location=M0E&ownerGroups=1126,1121,1174,1163&status=DRAFT&subjects=12790
//
https://vle.learning.moe.edu.sg/manage-resource?resource=LESSON&location=M0E&ownerGroups=1126,1121,1174,1163&status=REJECTED&subjects=12790
wait 5•// ensure new data is read on browser after taking first result again
//• does not have graceful handling 20 is just a number for the first page //• to do more pages restart the flow again type delete. tag in cd
end = 20
for.1-from-1-to end
click (//a[@tag=' component'] [normalize-space()='Open']) ['i']
PROBLEMS
TERMINA!
DEBUG CONSOLE
PORTS
click //li[@class='delete moe-library']//al@class='cv-link bx--link'] click OK
https://vle.learning-moe.edu.sg/manage-resource?resource=LESSON&location=M0E&oWnerGroups=1126,1121,1174, 1163&status=REJECTED&subjects=12790 - Manage Modules
FINISH - automation finished -
145.0s
• lookang@l-wee-11412 pohYin&
曰…
Dzsh +<日… ^X
