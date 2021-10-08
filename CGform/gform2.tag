//https://tagui.readthedocs.io/en/latest/reference.html
js begin
//
js finish

//visit URL
https://vle.learning.moe.edu.sg/mrv/community-gallery/admin

//assume no login
if present('button login bx--btn bx--btn--primary')
    click .button.login
    wait 5

    code = ""
    https://mail.google.com/mail/u/0/#inbox"
    // Click Sign in 
    wait 5
    // click the first email by notifications@sls.ufinity.com in the table
    click //*[@email="notifications@sls.ufinity.com"]/ancestor-or-self::tr
    read //div[7]/div[3]/div/div[2]/div[1]/div[2]/div/div/div/div/div[2]/div/div[1]/div/div[2]/div/table/tr/td[1]/div[2]/div[2]/div/div[3]/div/div/div/div/div/div[1]/div[2]/div[3]/div[3]/div/div[2]/h2 to code
    echo `code`
    wait 5

    // go back to SLS
    https://vle.learning.moe.edu.sg/mrv/community-gallery/admin
    type otp as `code`
    click .field-set.type-button.otp-submit button
    wait 5 


click //a[@id="approved-link"]
//read data on table first
//read /html/body/div[1]/main/div/div/section/div/div[2]/div/div[2]/div[1]/div/div/div/div[1]/table/tbody/tr[1]/td[4]/div/span to course
read //*[@id="approved"]/div/div/div/div[1]/table/tbody/tr[1]/td[1]/div/div/span to course
echo `course`

//read //body[1]/div[1]/main[1]/div[1]/div[1]/section[1]/div[1]/div[2]/div[1]/div[2]/div[1]/div[1]/div[1]/div[1]/div[1]/table[1]/tbody[1]/tr[1]/td[3]/div[1]/span[1] to subject
read //*[@id="approved"]/div/div/div/div[1]/table/tbody/tr[1]/td[3]/div/span to subject
echo `subject`

read //*[@id="approved"]/div/div/div/div[1]/table/tbody/tr[1]/td[4]/div/span to standard
echo `standard`
echo "standardlength="`standard.length`

//click on OPEN to read more info
//click /html[1]/body[1]/div[1]/main[1]/div[1]/div[1]/section[1]/div[1]/div[2]/div[1]/div[2]/div[2]/div[1]/div[1]/div[1]/div[1]/table[1]/tbody[1]/tr[1]/td[1]/div[1]/div[1]/div[1]/a[1]
click //*[@id="approved"]/div/div/div/div[1]/table/tbody/tr[1]/td[1]/div/div/div/a
//click cv-link bx--link

//click //a[contains(text(),"Open")]
read output-text to title
echo `title`
js link = url()
echo `link`

https://docs.google.com/forms/d/e/1FAIpQLSeWt27t9Hys2CixHUiYF76eOWFTlxyPGSHLNTLTrLN93Nm1XQ/viewform

//category



//declare
category = ""
//trim to remove space
//toLowerCase convert all to lower cases
js subject = subject.trim().toLowerCase()

if subject contains 'english' or 'literature'
    category = "English and Literature"
    click //*[@id="i9"]/div[3]/div
else if subject contains 'math'
    category = "Mathematics"
    click //div[@id='i12']
else if subject contains 'science' or 'physic' or 'chem' or 'bio'
    category = "Sciences"
    click //div[@id='i15']
else if subject contains 'humani' or 'social' or 'geo' or 'hist'
    category = "Humanities"
    click //div[@id='i18']
else if subject contains 'chin' or 'mala' or 'tamil'
    category = "Mother Tongue Languages"
    click //div[@id='i21']
else if subject contains 'design' or 'other' or 'music'
    category = "Other Subjects"
    click //div[@id='i24']
//else 
//    category = "Other Subjects"
//    click //div[@id='i24']


echo category = `category`

//standard
//standardfirstword = standard.split(" ")[0]
//echo `standardfirstword`
if standard contains "Primary"
    //echo `standardfirstword`
    click //*[@id="i35"]/div[3]/div

else if standard contains "Secondary"
    //echo `standardfirstword`
    click //*[@id="i38"]/div[3]/div

else if standard contains "Pre U"
    //echo `standardfirstword`
    click //*[@id="i41"]/div[3]/div

echo standard = `standard`


//level
//standard = "Secondary 3 Express, Secondary 4 Express, Secondary 5 Normal (A), Secondary 3 Normal (A), Secondary 4 Normal (A), Secondary 3 Normal (A), Secondary 4 Normal (A)"
//standardArr = standard.split(', '); // to split using 'comma and space'



    if standard contains "Pre-U 1"
        read //*[@id="i49"]//@aria-checked to checkpu1
        if (checkpu1=='false')
        {
        click //*[@id="i49"]/div[2]
        }

    if standard contains "Pre-U 2"
        read //*[@id="i52"]//@aria-checked to checkpu2
        if (checkpu2=='false')
        {
        click //*[@id="i52"]/div[2]
        }

    if standard contains "Pre-U 3"
        read //*[@id="i55"]//@aria-checked to checkpu3
        if (checkpu3=='false')
        {
        click //*[@id="i55"]/div[2]
        }

    if standard contains "Primary 1"
        read //*[@id="i58"]//@aria-checked to checkp1
        if (checkp1=='false')
        {
        click //*[@id="i58"]/div[2]
        }

    if standard contains "Primary 2"
        read //*[@id="i61"]//@aria-checked to checkp2
        if (checkp2=='false')
        {
        click //*[@id="i61"]/div[2]
        }

    if standard contains "Primary 3"
        read //*[@id="i64"]//@aria-checked to checkp3
        if (checkp3=='false')
        {
        click //*[@id="i64"]/div[2]
        }

    if standard contains "Primary 4"
        read //*[@id="i67"]//@aria-checked to checkp4
        if (checkp4=='false')
        {
        click //*[@id="i67"]/div[2]
        }

    if standard contains "Primary 5"
        read //*[@id="i70"]//@aria-checked to checkp5
        if (checkp5=='false')
        {
            click //*[@id="i70"]/div[2]
        }

    if standard contains "Primary 6"
        read //*[@id="i73"]//@aria-checked to checkp6
        if (checkp6=='false')
        {
        click //*[@id="i73"]/div[2]
        }
    
    if standard contains "Secondary 1"
        read //*[@id="i76"]//@aria-checked to checks1
        if (checks1=='false')
        {
        click //*[@id="i76"]/div[2]
        }

    if standard contains "Secondary 2"
        read //*[@id="i79"]//@aria-checked to checks2
        if (checks2=='false')
        {
        click //*[@id="i79"]/div[2]
        }

    if standard contains "Secondary 3"
        read //*[@id="i82"]//@aria-checked to checks3
        if (checks3=='false')
        {
        click //*[@id="i82"]/div[2]
        }

    if standard contains "Secondary 4"
        read //*[@id="i85"]//@aria-checked to checks4
        if (checks4=='false')
        {
        click //*[@id="i85"]/div[2]
        }

    if standard contains "Secondary 5"
        read //*[@id="i88"]//@aria-checked to checks5
        if (checks5=='false')
        {
        click //*[@id="i88"]/div[2]
        }





click //div[@role='listbox']
//subject = "BASIC BAHASA MELAYU"
arr = subject.split(" ")
word = ""
js begin
arr.forEach(myFunction);
function myFunction(item, i) {
  if (item=="OF"||item=="IN"||item=="AND"){ //handle words not toUpperCase
      word += item.toLowerCase();
  }
  
  else{
      word += item.charAt(0).toUpperCase() + item.slice(1, item.length).toLowerCase();
  }
  if (i < arr.length-1) word += " ";
}
// handle s in principle
if (word=="Principles of Accounts"){
    word = "Principle of Accounts"
} 
// handle Physical Education
if (word=="Physical Education"){
    word = "PE"
} 
// handle English Language
if (word=="English Language"){
    word = "English"
} 
// handle Malay N(a)
if (word=="Malay N(a)"){
    word = "Malay"
} 
if (word=="Design & Technology"){
    word = "D&T"
} 
js finish
echo word = `word`
click //div[@role='option'][normalize-space()='`word`']


//course

standard= standard.trim().toLowerCase()
echo standard = `standard`
if standard contains 'express'
    click //div[@id='i96']

if standard contains 'acad'
    click //div[@id='i99']

if standard contains 'tech'
    click //div[@id='i102']

if standard contains 'nil'
    click //div[@id='i105']

else
    click //div[@id='i105']


// first is Topic/Theme
//type //input[@type='text'][1] as `title`
//lack of a better topic
type //input[@type='text'] as `title`

//second is Lesson Title
//type //input[@type='text'][2] as `title` 
//click quantumWizTextinputPaperinputInputArea
type /html/body/div/div[2]/form/div[2]/div/div[2]/div[9]/div/div/div[2]/div/div[1]/div/div[1]/input as `title`

type //input[@type='url'] as `link.replace('admin/','')`

//assume ok
click Submit
// confirm look 
wait 5000