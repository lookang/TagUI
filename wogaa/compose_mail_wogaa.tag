//load body_template.txt to body
load emailTemplate.txt to body
//load body_templatemassemail.txt to body
//load pendingreview_list.csv to pending_table
// thanks to python3 code test11.py the new file is output.csv 
load singapore_student_learning_space_(sls)-daily-04_01_2021_Filtered.csv to pending_table
[singapore_student_learning_space_(sls)-daily-04_01_2021_Filtered.xlsx]Sheet1!A:N16 = pending_table

// code by Marcelo Cecin
// install from https://xlsxwriter.readthedocs.io/getting_started.html 
// pip install XlsxWriter
py begin
import os
import glob
import csv
from xlsxwriter.workbook import Workbook
// need to replace with your own path, in windows maybe something like c:/rpa/tagui/flows/wogaa
for csvfile in glob.glob(os.path.join('/Users/lookang/Desktop/tagui/flows/wogaa/', '*.csv')):
    workbook = Workbook(csvfile[:-4] + '.xlsx')
    worksheet = workbook.add_worksheet()
    with open(csvfile, 'rt', encoding='utf8') as f:
        reader = csv.reader(f)
        for r, row in enumerate(reader):
            for c, col in enumerate(row):
                worksheet.write(r, c, col)
    workbook.close()
py finish



DateTime = [singapore_student_learning_space_(sls)-daily-04_01_2021_Filtered.xlsx]singapore_student_learning_spac!A2:A16 
// DateTime = [singapore_student_learning_space_(sls)-daily-04_01_2021_Filtered.csv]singapore_student_learning_space_(sls)-daily-04_01_2021_Filtered!A2  
echo `DateTime`
ServiceName = [singapore_student_learning_space_(sls)-daily-04_01_2021_Filtered.xlsx]singapore_student_learning_spac!B2:B16  
TXNID = [singapore_student_learning_space_(sls)-daily-04_01_2021_Filtered.xlsx]singapore_student_learning_spac!C2:C16
PageURL = [singapore_student_learning_space_(sls)-daily-04_01_2021_Filtered.xlsx]singapore_student_learning_spac!D2:D16  
BrowserVersion = [singapore_student_learning_space_(sls)-daily-04_01_2021_Filtered.xlsx]singapore_student_learning_spac!E2:E16  
OSDevice = [singapore_student_learning_space_(sls)-daily-04_01_2021_Filtered.xlsx]singapore_student_learning_spac!F2:F16  
Geographic = [singapore_student_learning_space_(sls)-daily-04_01_2021_Filtered.xlsx]singapore_student_learning_spac!G2:G16  
Rating = [singapore_student_learning_space_(sls)-daily-04_01_2021_Filtered.xlsx]singapore_student_learning_spac!H2:H16  
EmailAddress = [singapore_student_learning_space_(sls)-daily-04_01_2021_Filtered.xlsx]singapore_student_learning_spac!I2:I16  
Name = [singapore_student_learning_space_(sls)-daily-04_01_2021_Filtered.xlsx]singapore_student_learning_spac!J2:J16 
MessageTitle = [singapore_student_learning_space_(sls)-daily-04_01_2021_Filtered.xlsx]singapore_student_learning_spac!K2:K16  
MessageBody = [singapore_student_learning_space_(sls)-daily-04_01_2021_Filtered.xlsx]singapore_student_learning_spac!L2:L16  
// M is blank
GotContent = [singapore_student_learning_space_(sls)-daily-04_01_2021_Filtered.xlsx]singapore_student_learning_spac!N2:N16  


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
	js currentDate = new Date()
	// Click 'Compose' button
	click Compose
	
	
	// Recipient
	type //textarea[@name="to"] as slscgbot@gmail.com 

	// Adding CC
	click //span[@role="link"][contains(@data-tooltip, "Add Cc")]
	
	type //textarea[@name="cc"] as Lawrence_WEE@moe.gov.sg; slscgbot@gmail.com ; zengwei2020work@gmail.com
		
	// Subject
	type //input[@name="subjectbox"] as Forwarded WOGAA widget email

	// Body //div[@id=':11x']
	click //*[@id=":s3"]
	type Body as Dear SLS Helpdesk,[enter] This is an email sent automatically at `currentDate` from WOGAA Sentiment Response Daily File. [enter]
	type Body as -------------------------------------------------------------------------- [enter]
	type Body as Date/Time: `DateTime[i]` [enter]
	type Body as Service Name: `ServiceName[i]`	[enter]
	type Body as TXN ID: `TXNID[i]` [enter]
	type Body as Page URL: `PageURL[i]` [enter]
	type Body as Browser Version: `BrowserVersion[i]` [enter]
	type Body as OS/Device: `OSDevice[i]` [enter]
	type Body as Geographic: `Geographic[i]` [enter]	
	type Body as Rating: `Rating[i]` [enter]
	type Body as Email Address: `EmailAddress[i]` [enter]
	type Body as Name: `Name[i]` [enter]
	type Body as Message Title:	`MessageTitle[i]` [enter]
	type Body as Message Body: `MessageBody[i]` [enter]
	type Body as -------------------------------------------------------------------------- [enter]
	type Body as [enter]
	type Body as Regards, [enter]
	type Body as SLS MOE Team
	wait 3	

	//Send Button
	click //div[@role="button"][contains(@data-tooltip, "Send")]
	// Schedule tommorow morning
	//click G-asx
	//click J-N yr
	//click Tomorrow morning    







