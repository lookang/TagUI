// type 
//tagui update in cmd to get the latest bug fix for mac csv width
//Downloading and updating to latest version of TagUI (v6.110)
//TagUI successfully updated at //Users/lookang/Desktop/tagui 
// https://www.youtube.com/watch?v=NV9b-pOBggo
// step 0: install Tagui from https://tagui.readthedocs.io/en/latest/setup.html 
// step 0.5: Windows recommended https://github.com/kelaberetiv/TagUI/releases/download/v6.46.0/TagUI_Windows.exe 
// step 1: download *.csv into the tagui folder example: /Users/lookang/Desktop/tagui/flows/wogaa or c:/rpa/tagui/flow/wogaa depending on Mac or Windows
// step 1.5 if need chinese character support, use UTF-8 see https://weelookang.blogspot.com/2022/06/how-to-make-csv-files-sent-to-be-read.html to convert
// step 2: navigate in cmd or terminal to the folder say cd /Users/lookang/Desktop/tagui/flows/wogaa/ or cd c:/rpa/tagui/flow/wogaa/
// step 3: using code editor example VS code to edit the line on filename to the correct file
// step 4: using cmd type: tagui compose_mail_wogaa5.tag
// code to run in cmd
// normal speed
// tagui compose_mail_wogaa5.tag
//FINISH - automation finished - 1052.7s for 59 emails
// 
// prepration need to do once only to prepare the TagUI chrome browser with login and password
// type in cmd: tagui live 
// use the TagUi chrome browser to login and password to your gmail to send emails out using the RPA, this is invisible in the code and only the browser knows so it is safe.
// now you can run step 4:
// step 4b: tagui compose_mail_wogaa5.tag -turbo
//or experimental, super human speed
// tagui compose_mail_wogaa5.tag -turbo
//FINISH - automation finished - 159.5s for 59 emails

// need to edit the filename manually
filename = "singapore_student_learning_space_(sls)-daily-13_06_2022_filtered"
filedate = filename.substring(45, 65)
column_A = [`filename`.csv]singapore_student_learning_spac!A:A
//echo `column_A`
filelength = column_A.length

load `filename`.csv to body

js begin

// CSV PARSER FUNCTION (reference: http://stackoverflow.com/a/1293163/2343)
function CSVToArray(strData, strDelimiter){
	strDelimiter = (strDelimiter || ",");
	// Create a regular expression to parse the CSV values.
	var objPattern = new RegExp(
		(
			// Delimiters.
			"(\\" + strDelimiter + "|\\r?\\n|\\r|^)" +

			// Quoted fields.
			"(?:\"([^\"]*(?:\"\"[^\"]*)*)\"|" +

			// Standard fields.
			"([^\"\\" + strDelimiter + "\\r\\n]*))"
		),
		"gi"
	);

	// Create an array to hold our data.
	var arrData = [[]];

	// Create an array to hold our individual pattern
	// matching groups.
	var arrMatches = null;

	// Keep looping over the regular expression matches
	// until we can no longer find a match.
	while(arrMatches = objPattern.exec(strData)){

		// Get the delimiter that was found.
		var strMatchedDelimiter = arrMatches[1]; 

		// Check to see if the given delimiter has a length
		// (is not the start of string) and if it matches
		// field delimiter. If id does not, then we know
		// that this delimiter is a row delimiter.
		if(strMatchedDelimiter.length && strMatchedDelimiter !== strDelimiter){
			// Since we have reached a new row of data,
			// add an empty row to our data array.
			arrData.push([]);
		}

		var strMatchedValue;
		// Now that we have our delimiter out of the way,
		// let's check to see which kind of value we
		// captured (quoted or unquoted).
		if(arrMatches[2]){

			// We found a quoted value. When we capture
			// this value, unescape any double quotes.
			strMatchedValue = arrMatches[2].replace(
				new RegExp( "\"\"", "g" ),
				"\""
			);

		} 
		else{
			// We found a non-quoted value.
			strMatchedValue = arrMatches[3];
		}

		// Now that we have our value string, let's add
		// it to the data array.
		arrData[arrData.length - 1].push(strMatchedValue);
	}

	// Return the parsed data.
	return(arrData);
}

pending = CSVToArray(body);

//declare an arrays
DateTime = [];
ServiceName = [];
TXNID = []
PageURL = []
BrowserVersion = []
OSDevice =[]
Geographic =[]
Rating =[]
EmailAddress =[]
Name = []
MessageTitle =[]
MessageBody =[]
GotContent = []


start_from_sn = 1;

for(var k = start_from_sn; k < pending.length; k++){
//for(var k = start_from_sn; k < 2; k++){
////console.log(pending[1]);
//console.log(pending[2]);
row = pending[k];
console.log("row = "+ row);
DateTime[k] = row[0] 
console.log("DateTime = " +DateTime[k]);
// DateTime = 13/6/22 21:26
ServiceName[k] = row[1]
TXNID[k] = row[2]
PageURL[k] = row[3]
BrowserVersion[k] = row[4]
OSDevice[k] = row[5]
Geographic[k] = row[6]
Rating[k] = row[7]
EmailAddress[k] = row[8]
console.log("EmailAddress = " +EmailAddress[k]);
// EmailAddress = 瑞恩@gmail.com
Name[k] = row[9]
MessageTitle[k] = row[10]
MessageBody[k] = row[11]
// M is blank
//N is unused
GotContent[k] = row [14]
}

js finish




echo outside DateTime = `DateTime`
// output is  outside DateTime = 1
//wait 100


dump `([ 'DataTime', 'ServiceName','TXNID','PageURL', 'BrowserVersion','OSDevice','Geographic','Rating','EmailAddress','Name','MessageTitle','GotContent' ])` to publish_list.csv


////////////////////////////////////////////////////////

// Open gmail (assumes that user has already logged in previously) see line 17

https://mail.google.com/mail/u/0/#inbox


wait 3

// change here for start, sometimes you may want to resend from another number
// if start = 24, the email row is 26
start = 1
for i from start to filelength-2
	//js pending.push([DateTime[i], ServiceName[i],TXNID[i],PageURL[i],BrowserVersion[i],OSDevice[i],Geographic[i], Rating[i],EmailAddress[i], Name[i],MessageTitle[i],GotContent[i]])
	// write file line by line so if breaks, still got some runs data done.
	//write `csv_row(pending[pending.length - 1])` to publish_list.csv
	j = i+1
	js currentDate = new Date()
	// Click 'Compose' button
	click Compose
	
	
	// Recipient
	//type //textarea[@name="to"] as  helpdesk@sls.ufinity.com
	
	// Adding CC
	//click //span[@role="link"][contains(@data-tooltip, "Add Cc")]
	
	type //textarea[@name="cc"] as  zengwei2020work@gmail.com
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







