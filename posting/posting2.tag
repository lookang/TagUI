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
https://weelookang.blogspot.com/?m=1
read .mobile-date-outer.date-outer:nth-child(1) h3 to variable
click .mobile-date-outer.date-outer:nth-child(1) h3
// to read the url to a variable, use javascript 
js variable2 = url() 

js console.log(variable, variable2)
wait 5

//Enter in to SLS

https://flipboard.com/

click svg.flip-compose-icon
wait 3
type flip-compose-flip-url as `variable2`
type flip-compose__form-caption as `variable`
click flip-magazine__body ui-text--body-2
click button--base button--primary
wait 3

