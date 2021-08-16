//https://tagui.readthedocs.io/en/latest/reference.html
js begin
//
js finish

//visit URL
https://vle.learning.moe.edu.sg/mrv/community-gallery/admin
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
js begin
// A function to detect sub-strings example Mathematics is detected as Math
function containsSubstring(str, sub_str)
{
var idx = str.indexOf(sub_str);
if(idx == -1){
    return 0;
            }
else {
    return 1;
    }
}



//declare
category = ""
//trim to remove space
//toLowerCase convert all to lower cases
subject = subject.trim().toLowerCase()

if(containsSubstring(subject, 'english')){
    category = "English and Literature"
    //click //div[@id='i9']
}
if(containsSubstring(subject, 'literature')){
    category = "English and Literature"
    //click //div[@id='i9']
}
if(containsSubstring(subject, 'math')){
    category = "Mathematics"
    //click //div[@id='i12']
}
if(containsSubstring(subject, 'science')){
    category = "Sciences"
    //click //div[@id='i15']
}
if(containsSubstring(subject, 'physic')){
    category = "Sciences"
    //click //div[@id='i15']
}
if(containsSubstring(subject, 'chem')){
    category = "Sciences"
    //click //div[@id='i15']
}
if(containsSubstring(subject, 'bio')){
    category = "Sciences"
    //click //div[@id='i15']
}
if(containsSubstring(subject, 'humani')){
    category = "Humanities"
    //click //div[@id='i18']
}
if(containsSubstring(subject, 'geo')){
    category = "Humanities"
    //click //div[@id='i18']
}
if(containsSubstring(subject, 'hist')){
    category = "Humanities"
    //click //div[@id='i18']
}
if(containsSubstring(subject, 'chin')){
    category = "Mother Tongue Languages"
    //click //div[@id='i21']
}
if(containsSubstring(subject, 'mala')){
    category = "Mother Tongue Languages"
    //click //div[@id='i21']
}
if(containsSubstring(subject, 'tamil')){
    category = "Mother Tongue Languages"
    //click //div[@id='i21']
}
else {
    category = "Other Subjects"
    //click //div[@id='i24']
}
js finish
echo category=`category`
// tagui lines since js and tagui cannot mix
if (category == "English and Literature")
    click //div[@id='i9']
else if (category == "Mathematics")
    click //div[@id='i12']
else if (category == "Sciences")
    click //div[@id='i15']
else if (category == "Humanities")
    click //div[@id='i18']
else if (category == "Mother Tongue Languages")
    click //div[@id='i21']
else if (category == "Others")
    click //div[@id='i24']
else 
    click //div[@id='i24']


//standard
standardfirstword = standard.split(" ")[0]
//echo `standardfirstword`
if (standardfirstword=="Primary")
{
    //echo `standardfirstword`
    click //*[@id="i35"]/div[3]/div
}
else if (standardfirstword=="Secondary")
{
    //echo `standardfirstword`
    click //*[@id="i38"]/div[3]/div
}
else if (standardfirstword=="Pre U")
{
    //echo `standardfirstword`
    click //*[@id="i41"]/div[3]/div
}


//level
//standard = "Secondary 3 Express, Secondary 4 Express, Secondary 5 Normal (A), Secondary 3 Normal (A), Secondary 4 Normal (A), Secondary 3 Normal (A), Secondary 4 Normal (A)"
standardArr = standard.split(', '); // to split using 'comma and space'
echo "standardArr2="`standardArr`
//standardArr = standard.trim() // to remove the first space for 2nd 3rd arrays
//echo "standardArr1="`standardArr`

echo `standardArr.length`
// comments line cannot be added everywhere, has to be outside
// to handle cases when there is only one Primary 1 for example
if (standardArr.length==1)
{ 
firstChunk = standardArr
}
else 
{
    for i from 1 to (standardArr.length) 
        //undefined is not an object (evaluating 'standardArr[i].indexOf') when 1
        index = standardArr[i].indexOf( ' ', standardArr[i].indexOf( ' ' ) + 1 );
        echo "index="`index`
        firstChunk = standardArr[i].substr( 0, index );
        echo "firstChunk="`firstChunk`
        echo "i="`i ``firstChunk`
}

    if (firstChunk=="Pre-U 1")
    {
        read //*[@id="i49"]//@aria-checked to checkpu1
        if (checkpu1=='false')
        {
        click //*[@id="i49"]/div[2]
        }
    }
    if (firstChunk=="Pre-U 2")
    {
        read //*[@id="i52"]//@aria-checked to checkpu2
        if (checkpu2=='false')
        {
        click //*[@id="i52"]/div[2]
        }
    }
    if (firstChunk=="Pre-U 3")
    {
        read //*[@id="i55"]//@aria-checked to checkpu3
        if (checkpu3=='false')
        {
        click //*[@id="i55"]/div[2]
        }
    }
    if (firstChunk=="Primary 1")
    {
        read //*[@id="i58"]//@aria-checked to checkp1
        if (checkp1=='false')
        {
        click //*[@id="i58"]/div[2]
        }
    }
    if (firstChunk=="Primary 2")
    {
        read //*[@id="i61"]//@aria-checked to checkp2
        if (checkp2=='false')
        {
        click //*[@id="i61"]/div[2]
        }
    }
    if (firstChunk=="Primary 3")
    {
        read //*[@id="i64"]//@aria-checked to checkp3
        if (checkp3=='false')
        {
        click //*[@id="i64"]/div[2]
        }
    }
    if (firstChunk=="Primary 4")
    {
        read //*[@id="i67"]//@aria-checked to checkp4
        if (checkp4=='false')
        {
        click //*[@id="i67"]/div[2]
        }
    }
    if (firstChunk=="Primary 5")
    {
        read //*[@id="i70"]//@aria-checked to checkp5
        if (checkp5=='false')
        {
            click //*[@id="i70"]/div[2]
        }
    }
    if (firstChunk=="Primary 6")
    {
        read //*[@id="i73"]//@aria-checked to checkp6
        if (checkp6=='false')
        {
        click //*[@id="i73"]/div[2]
        }
    }
    if (firstChunk=="Secondary 1")
    {
        read //*[@id="i76"]//@aria-checked to checks1
        if (checks1=='false')
        {
        click //*[@id="i76"]/div[2]
        }
    }
    if (firstChunk=="Secondary 2")
    {
        read //*[@id="i79"]//@aria-checked to checks2
        if (checks2=='false')
        {
        click //*[@id="i79"]/div[2]
        }
    }
    if (firstChunk=="Secondary 3")
    {
        //if exist('//*[@id="mG61Hd"]/div[2]/div/div[2]/div[6]/div/div/div[2]/div[1]/div[12]/label/div/div[contains(@aria-checked, "false")]')
        //read //*[@id="mG61Hd"]/div[2]/div/div[2]/div[6]/div/div/div[2]/div[1]/div[12]/label/div/div[contains(@aria-checked, "false")] to test
        //read /html[1]/body[1]/div[1]/div[2]/form[1]/div[2]/div[1]/div[2]/div[6]/div[1]/div[1]/div[2]/div[1]/div[12]/label[1]/div[1]/div[1][contains(@aria-checked, "false")] to checkboxs3
        //read //*[@id="i82"]/div[2]//@aria-checked to checks3
        read //*[@id="i82"]//@aria-checked to checks3
        if (checks3=='false')
        {
        click //*[@id="i82"]/div[2]
        }
    }
    if (firstChunk=="Secondary 4")
    {
        read //*[@id="i85"]//@aria-checked to checks4
        if (checks4=='false')
        {
        click //*[@id="i85"]/div[2]
        }
    }
    if (firstChunk=="Secondary 5")
    {
        read //*[@id="i88"]//@aria-checked to checks5
        if (checks5=='false')
        {
        click //*[@id="i88"]/div[2]
        }
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

js finish
echo `word`
click //div[@role='option'][normalize-space()='`word`']


//course
js begin
// A function to detect sub-strings example Mathematics is detected as Math
function containsSubstring(str, sub_str)
{
var idx = str.indexOf(sub_str);
if(idx == -1){
    return 0;
            }
else {
    return 1;
    }
}


// declare variables
courseE= "false"
courseNA = "false" 
courseNT = "false" 
courseNIL = "false"


standard= standard.trim().toLowerCase()

if(containsSubstring(standard, 'express')){
courseE = "true" 
}
if(containsSubstring(standard, 'acad')){
courseNA = "true" 
}
if(containsSubstring(standard, 'tech')){
courseNT = "true" 
}
else {
    courseNIL = "true"
    // set the rest to false when NIL is true
    courseE = "false"
    courseNA ="false"
    courseNT = "false" 
}

js finish

echo E=`courseE`
echo NA=`courseNA`
echo NT=`courseNT`
echo NIL=`courseNIL`

if (courseE == "true")
    click //div[@id='i96']
if (courseNA == "true")
    click //div[@id='i99']
if (courseNT == "true")
    click //div[@id='i102']
if (courseNIL == "true")
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