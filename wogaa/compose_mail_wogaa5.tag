// type 
//tagui update in cmd to get the latest bug fix for mac csv width
//Downloading and updating to latest version of TagUI (v6.110)
//TagUI successfully updated at //Users/lookang/Desktop/tagui 

// download csv into the tagui folder example: /Users/lookang/Desktop/tagui/flows/wogaa
// pre condition: convert csv to xlsx on your own (may be unncessary in v6.110)
// file needed: actual csv and the converted xlsx (manually convert)

// code to run in cmd
// normal speed
// tagui tagui compose_mail_wogaa5.tag
//FINISH - automation finished - 1052.7s for 59 emails

//or experimental, super human speed
// tagui compose_mail_wogaa5.tag -turbo
//FINISH - automation finished - 159.5s for 59 emails

// need to edit the filename manually
filename = "singapore_student_learning_space_(sls)-daily-13_06_2022_filtered"
filedate = filename.substring(45, 65)

column_A = [`filename`.csv]singapore_student_learning_spac!A:A
//echo `column_A`
filelength = column_A.length
//echo `temp`
//wait 1000

echo filelength manual = `filelength`
//wait 100

DateTime = [`filename`.csv]singapore_student_learning_spac!A2:A`filelength`
//DateTime = [singapore_student_learning_space_(sls)-daily-12_01_2021_Filtered.csv]singapore_student_learning_space_(sls)-daily-04_01_2021_Filtered!A2  
echo  `DateTime`
//filelength = DateTime.length
//echo filelength manual 2 = `filelength`
ServiceName = [`filename`.csv]singapore_student_learning_spac!B2:B`filelength` 
TXNID = [`filename`.csv]singapore_student_learning_spac!C2:C`filelength`
PageURL = [`filename`.csv]singapore_student_learning_spac!D2:D`filelength` 
BrowserVersion = [`filename`.csv]singapore_student_learning_spac!E2:E`filelength` 
OSDevice = [`filename`.csv]singapore_student_learning_spac!F2:F`filelength`
Geographic = [`filename`.csv]singapore_student_learning_spac!G2:G`filelength`
Rating = [`filename`.csv]singapore_student_learning_spac!H2:H`filelength`
EmailAddress = [`filename`.csv]singapore_student_learning_spac!I2:I`filelength`  
Name = [`filename`.csv]singapore_student_learning_spac!J2:J`filelength`
MessageTitle = [`filename`.csv]singapore_student_learning_spac!K2:K`filelength`
MessageBody = [`filename`.csv]singapore_student_learning_spac!L2:L`filelength`
// M is blank
//N is unused
GotContent = [`filename`.csv]singapore_student_learning_spac!N2:N`filelength`


////////////////////////////////////////////////////////

// Open gmail (assumes that user has already logged in previously)

https://mail.google.com/mail/u/0/#inbox


wait 3

// change here for start, sometimes you may want to resend from another number
// if start = 24, the email row is 26
start = 24
for i from start to filelength-2
	j = i+2
	js currentDate = new Date()
	// Click 'Compose' button
	click Compose
	
	
	// Recipient
	//type //textarea[@name="to"] as  helpdesk@sls.ufinity.com
	type //textarea[@name="to"] as  helpdesk@sls.ufinity.com
	// Adding CC
	//click //span[@role="link"][contains(@data-tooltip, "Add Cc")]
	
	//type //textarea[@name="cc"] as  zengwei2020work@gmail.com
	//type //textarea[@name="cc"] as  slscgbot@gmail.com	
	// Subject
	type //input[@name="subjectbox"] as Forwarded WOGAA widget email with cell row `j` from `filedate`

	
	dom_json = [currentDate,DateTime[i],ServiceName[i],TXNID[i],PageURL[i],BrowserVersion[i],OSDevice[i],Geographic[i],Rating[i],EmailAddress[i],Name[i],MessageTitle[i],MessageBody[i]]
	//control the formatting
	dom document.querySelector('div[aria-label="Message Body"]').setAttribute('style', 'white-space: pre;')
	//put in the text and variables using dom_json
	dom document.querySelector('div[aria-label="Message Body"]').innerHTML = "Dear SLS Helpdesk, <br> This is an email sent automatically at "+ dom_json[0] + " from WOGAA Sentiment Response Daily File. <br>-------------------------------------------------------------------------- <br>Date/Time: "+dom_json[1]+" <br>Service Name: 	"+dom_json[2]+"<br>TXN ID: "+dom_json[3]+" <br>Page URL: "+dom_json[4]+" <br>Browser Version: "+dom_json[5]+" <br>OS/Device: "+dom_json[6]+" <br>Geographic: "+dom_json[7]+" <br>Rating: "+dom_json[8]+" <br>Email Address: "+dom_json[9]+" <br>Name: "+dom_json[10]+" <br>Message Title:	"+dom_json[11]+" <br>Message Body: "+dom_json[12]+" <br>-------------------------------------------------------------------------- <br><br> Regards, <br>SLS MOE Team"

	// try to put a number to wait cos internet could be slow.
	wait 0.1

	//Send Button
	click //div[@role="button"][contains(@data-tooltip, "Send")]
	
	// Schedule tommorow morning
	//click G-asx
	//click J-N yr
	//click Tomorrow morning    







