//INSTALLATION
// https://tagui.readthedocs.io/en/latest/setup.html

// HOW TO USE
// copy the text here and create a text file and save it into your TagUI folder
// for me it was /Users/lookang/Desktop/tagui/flows/lookang/20210208
// to run the code, 
// use cmd line in Windows or terminal in MacOSX
// cd /Users/lookang/Desktop/tagui/flows/lookang/20210208
// type $  tagui loginSLSCGadmin.tag
// depending on your file name saved as loginSLSCGadmin.tag

// preconditions by lookang
// use the chrome that tagUI open and key in website username and website password
// chrome will offer to save password, click yes
//similarly when visiting gmail again enter your gmail and gmail password and save them on the browser that tagUI Opens
// when these are all done, there is not need to tagUI username password etc , just pure action code
// another condition is in the gmail, delete all previous  Verification Code for SLS Account Login, the script is not clever to scroll down to find the latest email

// WHAT THIS CODE DOES:
// 1. Visit SLS to trigger the 2FA, login is handle by Chrome password save 
// 2. Opens gmail, login is handle by Chrome password save
// 2b. Open the first email 
// 3. Get the 2FA code  

///////////////////////////////////

//Enter in to SLS
//https://vle.learning.moe.edu.sg/mrv/my-library/owned-by-me
https://vle.learning.moe.edu.sg/login

//using TagUI Web Automation
//type username as XX
//type password as XX
click .button.login
wait 5
//https://vle.learning.moe.edu.sg/authenticate
///////////////////////////////////

// PRECONDITION: allow popups on SLS site
// opens gmail in new window
dom gmail_window = window.open("https://mail.google.com/mail/u/0/#inbox")

code = ""

popup mail
	// If this is the first time logging into google from this browser, attempt to sign in
	if url() contains 'https://www.google.com/intl/en-GB/gmail/about/'
		
		// Click Sign in 
		click /html/body/div[2]/div[1]/div[4]/ul[1]/li[2]/a
		

		popup signin
			type //*[@id="identifierId"] as xx@gmail.com // replace xx with your own email address
			click Next
			type //*[@id="password"]/div[1]/div/div[1]/input as xx // replace xx with your own email password
			click Next
			wait 20


	wait 5
	// click the first email by notifications@sls.ufinity.com in the table
	click //*[@email="notifications@sls.ufinity.com"]/ancestor-or-self::tr

	// read the 2fa code 
	//line below is what i copied from the developer Xpath full path
	// read the 2fa code 
	read //div[7]/div[3]/div/div[2]/div[1]/div[2]/div/div/div/div/div[2]/div/div[1]/div/div[2]/div/table/tr/td[1]/div[2]/div[2]/div/div[3]/div/div/div/div/div/div[1]/div[2]/div[3]/div[3]/div/div[2]/h2 to code

	echo `code`
	wait 5 // if wrong i can manually copy from browser to continue debugging

// close gmail window
dom gmail_window.close()

type otp as `code`
click .field-set.type-button.otp-submit button

wait 5 //to load the SLS page correctly first before next step

///////////////////////////////////

https://vle.learning.moe.edu.sg/mrv/my-library/owned-by-me
// click to go inside folder of activity templates 
// not clever code always the 6 th rows
click //*[@id="main-content"]/div/div/section/div/div[2]/div[2]/div[2]/div[1]/table/tbody/tr[6]/td[2]/div/div/a
// sort by title in ascending order

click //*[@id="main-content"]/div/div/section/div/div[2]/div[2]/div[2]/div[1]/table/thead/tr/th[2]/span
// sort by title in decending order by clicking again
click //*[@id="main-content"]/div/div/section/div/div[2]/div[2]/div[2]/div[1]/table/thead/tr/th[2]/span
wait 3

// getting total_number of rows
read //div[@class="v-data-footer__pagination"] to pagination
js total = parseInt(pagination.split("of")[1].trim());

// creating row counter so that it can loop through the table properly
rowCnt = 1 // rename this to suit your purposes 
// 1 to 13 for team A1 and A2 01-10 include 02a,02b,02c
// 1 to 9 for team A3 and A4 22-11 
//js total=11 // enable one of this line to control end of loop table A1 A2
js total = 9 // enable for A3 A4

tableCnt = 0
pending = []

// always in groups of 20 now in UI
startrow = rowCnt 
for i from startrow to total 
	// click on threee dots to trigger menu to share
	wait 1 // when reach around 8, must scroll down the page a bit to help find the share button
	click //table//tr[`i`]/td[5]//button
	
	// click share menu
	click //div[@class="bx--overflow-menu-options bx--overflow-menu--flip bx--overflow-menu-options--open"]//ul/li[1]//button
	wait 2 // trying to understand why is it buggy here, increase to 2 sec wait
	//click add  // slow to find add automatically, repalce with xpath
	click cv-button add-collaborator-btn bx--btn bx--btn--primary
	 
	wait 2 // trying to understand why is it buggy here, increase to 2 sec wait
	click search.png
	//if present('search.png')
	//	click search.png	
	wait 2
	// if the keyboard key duplicates character, close the java program on the bottom right corner which was used by computer vision
	// A1 // names removed, replace Wee Loo Kang with your own requirements
	//keyboard Wee Loo Kang[enter] 
	
	
	//A2
	
	//keyboard Wee Loo Kang[enter]
	
	

	//A3
	//keyboard Wee Loo Kang[enter]
	

	//A4
	//keyboard Wee Loo Kang[enter]
	
	keyboard Wee Loo Kang[enter]

	wait 1
	
	echo waiting for human keyboard click to proceed on to next step
	wait 1 // wait for human enter
	// click to select all
	wait 1
	click /html/body/div[3]/div[2]/div/div[2]/div[1]/div[3]/div[2]/div[2]/div[1]/table/thead/tr/th[1]/div
	wait 2
	// click add is not reliable
	//click add
	click cv-button add-collaborator-btn bx--btn bx--btn--primary
	// assume after adding the permission combobox is the first one tagui finds
	//click bx--list-box__label // uncomment out if need edit rights
	//change selection
	//click Can Edit // uncomment out if need edit rights


	//click save
	click /html/body/div[3]/div/div/div[1]/div[2]/div/button
	wait 1
	//click X
	click button close sls-icon

	js rowCnt++; // row counter increase by 1
	if (rowCnt == 21)
		{
		click //button[@aria-label="Next page"]
		js tableCnt++;
		rowCnt = 1
		wait 2
		}
	

