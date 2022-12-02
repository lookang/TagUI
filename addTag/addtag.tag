

if iteration equals to 1
	echo login yourself to SLS
	live
else 
	//do ntg to skip live
	echo "do ntg"


// example https://tagui.readthedocs.io/en/latest/advanced.html#datatables
//to run type tagui addtag.tag adddata.csv
// need computer vision, so need primary monitor only.
// as this flow doesnt stop, quickly self login to the SLS
// accuracy is low now, with need for human clicks to assist RPA


//https://vle.learning.moe.edu.sg/mrv/studentgroup/51e41c68-7e54-4cef-bc04-5d959d7713d0?tab=admin
echo `URL.split('//')[1]`
https://`URL.split('//')[1]`
echo current iteration: `iteration`
//dataofurl[i]
click (//*[name()='svg'][@name='Kebab24'])
wait 1
click (//*[name()='svg'][@name='Pencil24'])
wait 1
click //button[@class='cv-button bx--btn bx--btn--primary bx--btn--field']
wait 1
click //a[@class='cv-link view-more bx--link']
type (//input)[2] as getmarked.ai,getmarked,QTI,QTI2.1,exam papers,SLS office
click (//*[name()='svg'][@name='Save24'])
click button close sls-icon
click CheckmarkCircle32
click //button[normalize-space()='OK']
click Play24
click //span[normalize-space()='OK']
// set the boolean to false to stop going into live mode
firsttime = 0
