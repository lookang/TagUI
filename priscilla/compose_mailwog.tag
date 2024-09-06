// tagui compose_mailwog.tag dataEmail.csv 

////////////////////////////////////////////////////////
echo `i`
echo `to`
echo `cc`
echo `bcc`
echo `subject`

//load ahead
word_text = [tagui_Email_to_SSEF_TCs.docx]
wait 10
echo `word_text`

//WOG web mail
https://webmail.sgmail.sgnet.gov.sg/owa/#path=/mail
//wait 5 //WOG slowed down alot 2022 10 05
//live

wait 3
if present ("//button[.//span[text()='OK']]")
    click //button[.//span[text()='OK']]

wait 1
click //button[@title='Write a new message (N)']

wait 1
type //input[@aria-label='To'] as `to`[enter];


click //input[@aria-label='Cc']
wait 1
type //input[@aria-label='Cc'] as  `cc`[enter]

wait 1
click //button[@title='Show Bcc']
wait 1
type //input[@aria-label='Bcc'] as `bcc`[enter]


//wait 3
wait 1
click  //input[@aria-label='Subject,']
wait 1
type //input[@aria-label='Subject,'] as `subject`



wait 3
//upload input[type="file"] as Merged_Email_to_SSEF_TCs.docx

// Body
//live
wait 3
word_text = [tagui_Email_to_SSEF_TCs.docx]

// Subject
wait 10
type //div[@aria-label='Message body'] as `word_text`



//click //span[contains(@class, 'ms-Icon--attachment')]
//upload //span[contains(@class, 'ms-Icon--attachment')] as Merged_Email_to_SSEF_TCs.docx


wait 1
click //button[@title='More actions']
click //button[@aria-label='Save draft']



// Send Button
live
//click Send
wait 3 // WOG slowed down alot after 20221003
// Schedule tommorow morning
//click G-asx
//click J-N yr
//click Tomorrow morning    





