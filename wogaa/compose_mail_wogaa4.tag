//load body_template.txt to body
//load emailTemplate.txt to body
//load body_templatemassemail.txt to body
//load pendingreview_list.csv to pending_table
// thanks to python3 code test11.py the new file is output.csv 
//load singapore_student_learning_space_(sls)-daily-04_01_2021_Filtered.csv to pending_table
//[singapore_student_learning_space_(sls)-daily-04_01_2021_Filtered.xlsx]Sheet1!A:N16 = pending_table

// code by Marcelo Cecin
// install from https://xlsxwriter.readthedocs.io/getting_started.html 
// pip install XlsxWriter
// python conversion didnt work, abort for the time being

// download csv into the tagui folder example: /Users/lookang/Desktop/tagui/flows/wogaa
// pre condition: convert csv to xlsx on your own
// file needed: actual csv and the converted xlsx (manually convert)

// code to run in cmd
// normal speed
// tagui tagui compose_mail_wogaa3.tag
//FINISH - automation finished - 1052.7s for 59 emails

//or experimental, super human speed
// tagui compose_mail_wogaa3.tag -turbo


filename = "singapore_student_learning_space_(sls)-daily-09_06_2022_filtered"


column_B = [`filename`.xlsx]singapore_student_learning_spac!B.B
filelength = column_B.length
echo filelength = `filelength`
//ask filelength is detected as "see cmd prompt filelength = " type 0 to continue with detected value or manually overwrite with your value (see csv or xls for the last row-1) ?
//echo `ask_result`
//if ask_result equals to '0'
//	echo using the detected filelength, if inacurrate, it will send more emails than in csv
//else 
//	filelength = Number(`ask_result`)
//	echo filelength manually inserted is = `filelength`

//manually overwrite as the code detect filelength as 131.
//manually determined as .length fails to get correct answer of 67, gave 131 instead
filelength = 59 

//wait 100
//DateTime = [singapore_student_learning_space_(sls)-daily-08_06_2022_filtered.xlsx]singapore_student_learning_spac!A2:A`filelength`
//DateTime = [`filename`.xlsx]singapore_student_learning_spac!A2:A`filelength`
DateTime = [`filename`.xlsx]singapore_student_learning_spac!A2:A`filelength`
// DateTime = [singapore_student_learning_space_(sls)-daily-04_01_2021_Filtered.csv]singapore_student_learning_space_(sls)-daily-04_01_2021_Filtered!A2  
echo  `DateTime`
ServiceName = [`filename`.xlsx]singapore_student_learning_spac!B2:B`filelength` 
TXNID = [`filename`.xlsx]singapore_student_learning_spac!C2:C`filelength`
PageURL = [`filename`.xlsx]singapore_student_learning_spac!D2:D`filelength` 
BrowserVersion = [`filename`.xlsx]singapore_student_learning_spac!E2:E`filelength` 
OSDevice = [`filename`.xlsx]singapore_student_learning_spac!F2:F`filelength`
Geographic = [`filename`.xlsx]singapore_student_learning_spac!G2:G`filelength`
Rating = [`filename`.xlsx]singapore_student_learning_spac!H2:H`filelength`
EmailAddress = [`filename`.xlsx]singapore_student_learning_spac!I2:I`filelength`  
Name = [`filename`.xlsx]singapore_student_learning_spac!J2:J`filelength`
MessageTitle = [`filename`.xlsx]singapore_student_learning_spac!K2:K`filelength`
MessageBody = [`filename`.xlsx]singapore_student_learning_spac!L2:L`filelength`
// M is blank
//N is unused
GotContent = [`filename`.xlsx]singapore_student_learning_spac!N2:N`filelength`


////////////////////////////////////////////////////////

// Open gmail (assumes that user has already logged in previously)
//ask 1 slscgbot@gmail.com or 2 wee_loo_kang@moe.edu.sg ?
//echo `ask_result`
//if ask_result contain '1'
https://mail.google.com/mail/u/0/#inbox
//else
	//https://mail.google.com/mail/u/1/?ogbl#inbox

wait 3

for i from 0 to DateTime.length
	j = i+1
	js currentDate = new Date()
	// Click 'Compose' button
	click Compose
	
	
	// Recipient
	//type //textarea[@name="to"] as  helpdesk@sls.ufinity.com
	//type //textarea[@name="to"] as  helpdesk@sls.ufinity.com
	// Adding CC
	click //span[@role="link"][contains(@data-tooltip, "Add Cc")]
	
	//type //textarea[@name="cc"] as  zengwei2020work@gmail.com
	type //textarea[@name="cc"] as  slscgbot@gmail.com	
	// Subject
	type //input[@name="subjectbox"] as Forwarded WOGAA widget email `j`

	// Body //div[@id=':11x']
	//click /html/body/div[24]/div/div/div/div[1]/div[3]/div[1]/div[1]/div/div/div/div[3]/div/div/div[4]/table/tbody/tr/td[2]/table/tbody/tr[1]/td/div/div[1]/div[2]/div[1]/div/table/tbody/tr/td[2]/div[2]/div
	//type //div[@aria-label="Message Body"] as Dear SLS Helpdesk,[enter] This is an email sent automatically at `currentDate` from WOGAA Sentiment Response Daily File. [enter]-------------------------------------------------------------------------- [enter]Date/Time: `DateTime[i]` [enter]Service Name: `ServiceName[i]`	[enter]TXN ID: `TXNID[i]` [enter]Page URL: `PageURL[i]` [enter]Browser Version: `BrowserVersion[i]` [enter]OS/Device: `OSDevice[i]` [enter]Geographic: `Geographic[i]` [enter]Rating: `Rating[i]` [enter]Email Address: `EmailAddress[i]` [enter]Name: `Name[i]` [enter]Message Title:	`MessageTitle[i]` [enter]Message Body: `MessageBody[i]` [enter]-------------------------------------------------------------------------- [enter][enter]Regards, [enter]SLS MOE Team
	//dom_json = {body: body}
	//dom document.querySelector('div[aria-label="Message Body"]').innerHTML = dom_json.body
	
	dom_json = [currentDate,DateTime[i],ServiceName[i],TXNID[i],PageURL[i],BrowserVersion[i],OSDevice[i],Geographic[i],Rating[i],EmailAddress[i],Name[i],MessageTitle[i],MessageBody[i]]
	//control the formatting
	dom document.querySelector('div[aria-label="Message Body"]').setAttribute('style', 'white-space: pre;')
	//js ss = "Dear SLS Helpdesk, \n This is an email sent automatically at "+ dom_json[0] + " from WOGAA Sentiment Response Daily File. \n-------------------------------------------------------------------------- \nDate/Time: "+dom_json[1]+" \nService Name: 	"+dom_json[2]+"\nTXN ID: "+dom_json[3]+" \nPage URL: "+dom_json[4]+" \nBrowser Version: "+dom_json[5]+" \nOS/Device: "+dom_json[6]+" \nGeographic: "+dom_json[7]+" \nRating: "+dom_json[8]+" \nEmail Address: "+dom_json[9]+" \nName: "+dom_json[10]+" \nMessage Title:	"+dom_json[11]+" \nMessage Body: "+dom_json[12]+" \n-------------------------------------------------------------------------- \n\n Regards, \nSLS MOE Team"
	//put in the text and variables using dom_json
	dom document.querySelector('div[aria-label="Message Body"]').innerHTML = "Dear SLS Helpdesk, <br> This is an email sent automatically at "+ dom_json[0] + " from WOGAA Sentiment Response Daily File. <br>-------------------------------------------------------------------------- <br>Date/Time: "+dom_json[1]+" <br>Service Name: 	"+dom_json[2]+"<br>TXN ID: "+dom_json[3]+" <br>Page URL: "+dom_json[4]+" <br>Browser Version: "+dom_json[5]+" <br>OS/Device: "+dom_json[6]+" <br>Geographic: "+dom_json[7]+" <br>Rating: "+dom_json[8]+" <br>Email Address: "+dom_json[9]+" <br>Name: "+dom_json[10]+" <br>Message Title:	"+dom_json[11]+" <br>Message Body: "+dom_json[12]+" <br>-------------------------------------------------------------------------- <br><br> Regards, <br>SLS MOE Team"
	//dom document.querySelector('div[aria-label="Message Body"]').innerHTML = ss.replace(/\n/g, '<br/>');
	//wait 1

	//Send Button
	click //div[@role="button"][contains(@data-tooltip, "Send")]
	// Schedule tommorow morning
	//click G-asx
	//click J-N yr
	//click Tomorrow morning    







