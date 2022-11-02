// login yourself
//live
// example https://tagui.readthedocs.io/en/latest/advanced.html#datatables
//to run type tagui addteachertoclassgroup.tag adddata.csv
// need computer vision, so need primary monitor only.
// as this flow doesnt stop, quickly self login to the SLS
// accuracy is low now, with need for human clicks to assist RPA

echo login yourself to SLS
//https://vle.learning.moe.edu.sg/mrv/studentgroup/51e41c68-7e54-4cef-bc04-5d959d7713d0?tab=admin
echo `URL.split('//')[1]`
https://`URL.split('//')[1]`
echo current iteration: `iteration`
//dataofurl[i]
click //button[normalize-space()='VIEW & EDIT']
wait 1
click //a[@id='teacher-link']
wait 1
click //button[normalize-space()='Add Teacher']
wait 1
//click //span[normalize-space()='Teacher as Student']

//click /html[1]/body[1]/div[3]/div[2]/div[1]/div[2]/div[1]/div[4]/div[1]/div[1]/div[1]/div[1]/input[1]
if present('findteacher.png')
	click findteacher.png
	wait 1 
	//to bring into focus
	click findteacher.png
	wait 1
else
	echo cannot find findteacher.png
//type /html[1]/body[1]/div[3]/div[2]/div[1]/div[2]/div[1]/div[4]/div[1]/div[1]/div[1]/div[1]/input[1] as Wong_Teck_Kiong [enter]
wait 1
// change manually the name of person to add
keyboard Wong_Teck_Kiong [enter]
wait 3
// to bring mouse away to prepare for findteacher.png
hover (10,10)
click //td[@class='text-start']//i[@class='v-icon notranslate mdi mdi-checkbox-blank-outline theme--light']
wait 3
click //span[normalize-space()='Add']



//click on Laison Officer
click /html[1]/body[1]/div[3]/div[1]/div[1]/div[2]/div[1]/div[2]/div[2]/div[2]/div[1]/div[2]/div[2]/div[1]/table[1]/tbody[1]/tr[5]/td[5]/div[1]/div[1]/div[1]/div[1]/button[1]/span[1]/span[1]
// change to Owner
click /html[1]/body[1]/div[3]/div[1]/div[1]/div[2]/div[1]/div[2]/div[2]/div[2]/div[1]/div[2]/div[2]/div[1]/table[1]/tbody[1]/tr[5]/td[5]/div[1]/div[1]/div[1]/div[1]/ul[1]/li[1]/a[1]/span[1]

//save
click //button[@class='cv-button bx--btn bx--btn--primary bx--btn--field bx--btn--icon-only']//*[name()='svg']
click //button[normalize-space()='OK']
