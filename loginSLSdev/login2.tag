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
// 2. Opens webmail, login is handle by Chrome password save
// 2b. Open the first email 
// 3. Get the 2FA code  

///////////////////////////////////
https://vle.dev.sls.ufinity.com/
// manually click away the pop up
wait 5 s
// button is the login button, surprising just a word will work, maybe only one button on page
click button


https://mail.dev.sls.ufinity.com/?_task=mail&_mbox=INBOX
// manually click away the message with username and password prepopulated
// click button called login
click submit
wait 3
// not sure if the firest email will change the id rcmrowNjUx
//click rcmrowNjUx
// click on first email
// take picture
//snap 
//click on email
click Verification Code 
// double click but not sure why not working
// dclick Verification Code 

// trying to get the URL and open the window
dom begin 
// gets the URL of new email
//window.open opens a new window
new_window = window.open(document.querySelector("tr.message:nth-child(1) a").getAttribute("href"))
dom finish

// browser needs to allow popups 
// declare code as variable
code = ""
//popup tells tagui to run the code in the new window
//https://tagui.readthedocs.io/en/latest/reference.html?highlight=popup#popup
//https://mail.dev.sls.ufinity.com/?_task=mail&_mbox=INBOX&_uid=1025&_action=show contains uid so we use it
//all can work, uid mail etc
//popup uid
popup mail
	wait 5
	// take snap will produce a picture in folder as snap.png as debugging
	snap //*[@id="message-htmlpart1"]/div/h2
	read //*[@id="message-htmlpart1"]/div/h2 to code

dom new_window.close()
echo code

wait 5
https://vle.dev.sls.ufinity.com/
type otp as `code`
click .field-set.type-button.otp-submit button
wait 10000
// i release these codes for educational purposes, it does not contains password etc. 
//happy learning TagUI.





