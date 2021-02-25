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


https://www.linkedin.com/feed/
wait 3
click artdeco-button artdeco-button--muted artdeco-button--4 artdeco-button--tertiary share-box-feed-entry__trigger--v2
type ql-editor ql-blank as `variable` `variable2`
click share-box_actions
wait 3

https://twitter.com/home
wait 3
click css-1dbjc4n r-13qz1uu
type css-1dbjc4n r-13qz1uu  as `variable` `variable2`
click css-18t94o4 css-1dbjc4n r-urgr8i r-42olwf r-sdzlij r-1phboty r-rs99b7 r-1w2pmg r-19u6a5r r-ero68b r-1gg2371 r-1ny4l3l r-1fneopy r-o7ynqc r-6416eg r-lrvibr
wait 3


https://flipboard.com/
wait 3
click svg.flip-compose-icon
type flip-compose-flip-url as `variable2`
type flip-compose__form-caption as `variable`
type flip-compose-magazine-search as ETD X-Labs
click flip-magazine__body ui-text--body-2
//click flip-compose-submit
//click //button[.="Flip"]
click //button[@class="button--base button--primary"]
wait 3



https://www.facebook.com/lookang
wait 3
click oajrlxb2 b3i9ofy5 qu0x051f esr5mh6w e9989ue4 r7d6kgcz rq0escxv nhd2j8a9 j83agx80 p7hjln8o kvgmc6g5 cxmmr5t8 oygrvhab hcukyx3x cxgpxx05 d1544ag0 sj5x9vvc tw6a2znq i1ao9s8h esuyzwwr f1sip0of lzcic4wl l9j0dhe7 abiwlrkh p8dawk7l bp9cbjyn orhb3f3m czkt41v7 fmqxjp7s emzo65vh btwxx1t3 buofh1pr idiwt2bm jifvfom9 ni8dbmo4 stjgntxs kbf60n1y
type _1mf _1mj as `variable` `variable2`
click rq0escxv l9j0dhe7 du4w35lb j83agx80 pfnyh3mw taijpn5t bp9cbjyn owycx6da btwxx1t3 c4xchbtz by2jbhx6
wait 3




https://www.facebook.com/OpenSourcePhysicsSG
wait 3
click oajrlxb2 tdjehn4e gcieejh5 bn081pho humdl8nn izx4hr6d rq0escxv nhd2j8a9 j83agx80 p7hjln8o kvgmc6g5 cxmmr5t8 oygrvhab hcukyx3x jb3vyjys d1544ag0 qt6c0cv9 tw6a2znq i1ao9s8h esuyzwwr f1sip0of lzcic4wl l9j0dhe7 abiwlrkh p8dawk7l beltcj47 p86d2i9g aot14ch1 kzx2olss cbu4d94t taijpn5t ni8dbmo4 stjgntxs k4urcfbm qypqp5cg
type _1mf _1mj as `variable` `variable2`
click k4urcfbm dati1w0a hv4rvrfc i1fnvgqd rq0escxv
wait 3


