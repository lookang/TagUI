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
https://vle.learning.moe.edu.sg/login

//using TagUI Web Automation
//type username as XX
//type password as XX
click .button.login
wait 5

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

https://vle.learning.moe.edu.sg/community-gallery/admin

// read https://tagui.readthedocs.io/_/downloads/en/latest/pdf/ for documentation
// idea syntax from https://github.com/kelaberetiv/TagUI/blob/master/flows/samples/4_loops.tag

wait 3

// getting number of rows
dom begin 
return document.querySelector("#tab0 > div > div >div:nth-child(2)").childElementCount
dom finish

pending = []

for i from 1 to dom_result
	read //*[@id="tab0"]/div/div/div[2]/div[`i`]/div[1]/span to title
	read //*[@id="tab0"]/div/div/div[2]/div[`i`]/div[2]/div to subject
	read //*[@id="tab0"]/div/div/div[2]/div[`i`]/div[3]/div to level
	read //*[@id="tab0"]/div/div/div[2]/div[`i`]/div[4]/div to school
	read //*[@id="tab0"]/div/div/div[2]/div[`i`]/div[5]/div to datesubmitted
	read //*[@id="tab0"]/div/div/div[2]/div[`i`]/div[5]/div[2] to author

	dom_json = {css_path: "#tab0 > div > div > div:nth-child(2) > div:nth-child(" + i + ")"}

	// checking for the 'similar' icon
	dom return document.querySelector(dom_json.css_path + " > div:nth-child(1) > a.hover-tooltip") ? 1 : -1
	similar = dom_result == -1 ? 0 : 1

	// checking for the 'resubmitted' label
	dom return document.querySelector(dom_json.css_path + " > div:nth-child(1) > label.resubmitted") ? 1 : -1
	resubmit = dom_result == -1 ? 0 : 1

	// get uuid
	dom begin
	return document.querySelector(dom_json.css_path).getAttribute('data-uuid')
	dom finish

	// construct url
	js begin
	url = "https://vle.learning.moe.edu.sg/community-gallery/admin/lesson/view/" + dom_result
	js finish

	js pending.push([i, title, subject, level, school, datesubmitted, author, url, similar, resubmit])

///////////////////// ASSIGNING TEACHERS AND DATES /////////////////////

load emails.csv to admin_table

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

// A function to form a simple date format (DD/MM/YYYY)
function formatDate(date_obj){
	var date_string = date_obj.getDate() + '/' + (date_obj.getMonth() + 1) + '/' + date_obj.getFullYear();
	return date_string;
}

// A function to detect sub-strings
function containsSubstring(str, sub_str){
	var idx = str.indexOf(sub_str);
	if(idx == -1)
		return 0;
	return 1;
}


// LINKING SUBJECT TO NAME
// NOTE: variables with 'var' will not be accessible outside this javascript code block
var subject_to_name = {};
var num_reviewed = {};

var admin_info = CSVToArray(admin_table);
for(var i = 0; i < admin_info.length; i++){
	if(i == 0)
		continue
	var row = admin_info[i];
	// getting the data
	var name = row[1].trim(), email = row[8].trim();
	var subject = [row[3].trim().toLowerCase(), row[4].trim().toLowerCase()];
	var reviewed = row[9].trim() == '' ? 0 : row[9];
	var active = row[10].trim();

	// if there is no registered email or the person is not active
	if(email == '' || active == '0')
		continue;

	// reviewed
	num_reviewed[name] = reviewed;

   for(var k = 0; k < subject.length; k++){  
		   if(subject[k] == '')
			   break;

		// subject to name (denotes which teacher belongs to which subjects)
		// eg. subject_to_name['chinese'] will give an array of chinese admins
		if(!(subject[k] in subject_to_name)){
			subject_to_name[subject[k]] = [];
		}
		subject_to_name[subject[k]].push(name);
   }
}

// console logging for clarity
console.log("List of available of subjects:");
for(sub in subject_to_name){
	console.log(sub);
}
console.log('------------');

////////////////////////////////////////////////////////

// CREATING DATE

var date_offset = 5; // (current day + 5 working days)

var due_date = new Date(Date.now()), cur_date = new Date(Date.now());

error_msg = '\n---------PLEASE REVIEW THE FOLLOWING MESSAGES---------\n';

// calculate working days
while(date_offset){
	due_date.setTime(due_date.getTime() + 1000 * 60 * 60 * 24);
	if(due_date.getDay() == 5 || due_date.getDay() == 6)
		continue;
	else
		date_offset--;
}

// DUE DATE OVERRIDE: Un-comment the below statement and replace the YYYY-MM-DD with desired date
// due_date = new Date('YYYY-MM-DD')

// ASSIGNING TEACHER AND DATES

for(var i = 0; i < pending.length; i++){

	// getting the data
	var row = pending[i];
	var subject = row[2].trim().toLowerCase();
	var similar = row[8], resubmitted = row[9];
	if(similar == 1 || resubmitted == 1){
		error_msg += 'ALERT: Item ' + row[0] + ' has been marked as either "similar" or "resubmitted", admin not assigned.\n';
		continue;
	}

	// NOTE: Due to inconsistency in subjects between email and pending tables, this is necessary to find the correct admins
	// HOWEVER, IN THE EVENT THAT IT IS UNABLE TO CAPTURE THE SUBJECT, PLEASE MANUALLY FILL IT IN THE CSV FILE

	// loops through all the available subjects listed in emails.csv
	for(sub in subject_to_name){
		// unique cases
		if(containsSubstring(subject, "design & technology")){
			subject = 'd&t';
			break;   
		}
		else if(containsSubstring(subject, "physical education")){
			subject = 'pe';
			break;
		}
		// for eg, if subject = "additional mathematics" and sub = "math"  
		// or, if sub = 'chinese language', and subject = 'chinese'
		else if(containsSubstring(subject, sub) || containsSubstring(sub, subject)){
			subject = sub;
			break;
		}
	}

	// error message if subject is not found
	if(!(subject in subject_to_name)){
		error_msg += 'ERROR: Item '+ row[0] +': Cannot find subject "'+subject+'", admin not assigned.\n';
		continue;
	}

	// ASSIGNING RECIPIENT 
	// sorting to get person with the lowest number of reviewed items
	subject_to_name[subject].sort(function(a, b){
		return num_reviewed[a] - num_reviewed[b];
	});

	var recipient_name = subject_to_name[subject][0];

	num_reviewed[recipient_name]++;

	pending[i] = pending[i].concat([recipient_name, formatDate(cur_date), formatDate(due_date)]);
}

js finish

// WRITING TO FILE
write `csv_row(["S/N", "Title", "Subject", "Level", "School", "Date Submitted", "Author", "URL", "Similar", "Resubmitted", "Assigned To", "Date Lesson Assigned", "Due Date"])` to pendingreview_list.csv
for i from 1 to pending.length
	write `csv_row(pending[i - 1])` to pendingreview_list.csv

echo `error_msg`
