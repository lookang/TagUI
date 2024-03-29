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
	//read //div[7]/div[3]/div/div[2]/div[1]/div[2]/div/div/div/div/div[2]/div/div[1]/div/div[2]/div/table/tr/td[1]/div[2]/div[2]/div/div[3]/div/div/div/div/div/div[1]/div[2]/div[3]/div[3]/div/div[2]/h2 to code
	// new otp xpath
	read /html/body/div[7]/div[3]/div/div[2]/div[2]/div/div/div/div/div[2]/div/div[1]/div/div[2]/div/table/tr/td[1]/div[2]/div[2]/div/div[3]/div/div/div/div/div/div[1]/div[2]/div[3]/div[3]/div/div[2]/h2 to code

	echo `code`
	wait 5 // if wrong i can manually copy from browser to continue debugging

// close gmail window
dom gmail_window.close()

type otp as `code`
click .field-set.type-button.otp-submit button

wait 5 //to load the SLS page correctly first before next step

///////////////////////////////////
