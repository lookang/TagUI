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
//visit URL
//https://vle.learning.moe.edu.sg/mrv/community-gallery/admin
https://vle.learning.moe.edu.sg/login
wait 1
// need to trigger 2 times as WOG is strict or buggy
https://vle.learning.moe.edu.sg/login

// chrome-extension://fpjohbpoggonmepkkifflkmkohefgcei/installation_message.html
// make sure you check DO NOT SHOW Jaga URL Reporter is a new browser extension that Public Officers can use to easily report suspicious websites that they may encounter while browsing the internet on Government-issued Secure Internet Surfing (SIS) enabled devices.
wait 5 //WOG slow
//assume no need to extra login
if present('loginform')
	// type username as MOE-00000H change
	type username as MOE-09615H
	click bx--text-input
	// type password as your_own change
	type bx--text-input as Shanshan1!!!!!
	click .button.login
	wait 5
	// this email is linked to your SLS alternative email for OTP, change this accordingly
	https://mail.google.com/mail/u/0/#inbox"
	// luckily WOG allows saving of gmail accounts so the steps below can be ommitted 
	//click Sign in
	//type Email or phone as slscgbot@gmail.com
	//click Next
	//type password as xxxxxxxxxxxxxxx
	//click Next
	// Click Sign in 
	wait 5
	// click the first email by notifications@sls.ufinity.com in the table
	click //*[@email="notifications@sls.ufinity.com"]/ancestor-or-self::tr
	//code = ""
	read //div[7]/div[3]/div/div[2]/div[1]/div[2]/div/div/div/div/div[2]/div/div[1]/div/div[2]/div/table/tr/td[1]/div[2]/div[2]/div/div[3]/div/div/div/div/div/div[1]/div[2]/div[3]/div[3]/div/div[2]/h2 to code
	echo `code`
	wait 5

	// go back to SLS
	https://vle.learning.moe.edu.sg/authenticate
	wait 5 
	type otp as `code`
	wait 5 
	click .field-set.type-button.otp-submit button
	wait 5 


// read https://tagui.readthedocs.io/_/downloads/en/latest/pdf/ for documentation
// idea syntax from https://github.com/kelaberetiv/TagUI/blob/master/flows/samples/4_loops.tag

wait 3


wait 5 //to load the SLS page correctly first before next step

///////////////////////////////////

https://vle.learning.moe.edu.sg/mrv/community-gallery/admin
// WOG seems to be recgnise the browser as first time visit everytime
// click the pop up away
if present ('walkme-custom-balloon-content')
	click walkme-custom-balloon-button walkme-custom-balloon-weak-button walkme-custom-balloon-cancel-button walkme-action-cancel walkme-click-and-hover

// read https://tagui.readthedocs.io/_/downloads/en/latest/pdf/ for documentation
// idea syntax from https://github.com/kelaberetiv/TagUI/blob/master/flows/samples/4_loops.tag

wait 3

// getting total_number of rows
read //div[@class="v-data-footer__pagination"] to pagination
js total = parseInt(pagination.split("of")[1].trim());

// creating row counter so that it can loop through the table properly

rowCnt = 1
// might want to change this to save time crawling all the assigned
tableCnt = 0
//tableCnt = 1
//tableCnt = 2
//tableCnt = 3
//tableCnt = 4

// loop to skip the specified number of tables
for i from 1 to tableCnt
	click //button[@aria-label="Next page"]

pending = []

// always in groups of 20 now in UI
for i from 1 to (total-tableCnt*20)
	// trying to break out if total is not found 
	if (exist('//*[@id="pending"]//table/tbody/tr[`rowCnt`]/td[1]/div/div/span'))
		read //*[@id="pending"]//table/tbody/tr[`rowCnt`]/td[1]/div/div/span to title
		read //*[@id="pending"]//table/tbody/tr[`rowCnt`]/td[2]/div/span to type
		read //*[@id="pending"]//table/tbody/tr[`rowCnt`]/td[3]/div/span to subject
		read //*[@id="pending"]//table/tbody/tr[`rowCnt`]/td[4]/div/span to level
		read //*[@id="pending"]//table/tbody/tr[`rowCnt`]/td[5]/div/span[1] to school
		read //*[@id="pending"]//table/tbody/tr[`rowCnt`]/td[6]/div/span[1] to datesubmitted
		read //*[@id="pending"]//table/tbody/tr[`rowCnt`]/td[6]/div/span[2] to author
	else
		break
	

	// trimming the author string to remove the 'By '
	js author = author.slice(3);
	// css path to the first column in the row
	dom_json = {css_path: "#pending table > tbody > tr:nth-child(" + rowCnt + ") > td:nth-child(1) > div "}

	// checking for the 'similar' icon
	dom return document.querySelector(dom_json.css_path + " > button.cv-tooltip") ? 1 : -1
	similar = dom_result == -1 ? 0 : 1

	// checking for the 'resubmitted' label
	dom return document.querySelector(dom_json.css_path + "span[title='Resubmitted']") ? 1 : -1
	resubmit = dom_result == -1 ? 0 : 1

	link = ""
	// lessons marked as similar will not have an accessible url in SLS
	if (similar == 0)
		{
		click //*[@id="pending"]//table/tbody/tr[`rowCnt`]/td[1]/div//a
		wait 3
	
		js link = url()
		echo `url()`
		echo `link`
		wait 1
		https://vle.learning.moe.edu.sg/mrv/community-gallery/admin

		for j from 1 to tableCnt
			click //button[@aria-label="Next page"]
			
		}
	// pending is an array collection of different variables
	js pending.push([i, title, type, subject, level, school, datesubmitted, author, link, similar, resubmit])
	js rowCnt++;
	if (rowCnt == 21)
		{
		click //button[@aria-label="Next page"]
		js tableCnt++; // maybe TagUI code has no ++ so use js
		rowCnt = 1
		wait 2
		}
	

///////////////////// ASSIGNING TEACHERS AND DATES /////////////////////
// admin_table is a TagUI code
// maybe TagUI can do it well, so using js to convert ot nice table of rows and columns
//load emails.csv to admin_table
load Subject Grps for Tracking_05Feb - emails.csv to admin_table

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

// A function to detect sub-strings example Mathematics is detected as Math
function containsSubstring(str, sub_str){
	var idx = str.indexOf(sub_str);
	if(idx == -1)
		return 0;
	return 1;
}

////////////////////////////////////////////////////////

// LINKING SUBJECT TO NAME OF REVIEWER
// NOTE: variables with 'var' will not be accessible outside this javascript code block

// subject to name (denotes which teacher belongs to which subjects at which level)
// eg. subject_to_name['pri']['chinese'] will give an array of chinese admins at a primary school level
var subject_to_name = {}, name_to_email = {};
var num_reviewed = {};

var admin_info = CSVToArray(admin_table);
for(var i = 0; i < admin_info.length; i++){
	if(i == 0)
		continue
	var row = admin_info[i];
	// getting the data
	var name = row[1].trim(), email = row[8].trim();
	var subject = [row[3].trim().toLowerCase(), row[4].trim().toLowerCase()], level = row[2].trim().toLowerCase();
	var reviewed = row[9].trim() == '' ? 0 : row[9];
	var active = row[10].trim();

	// if there is no registered email or the person is not active
	if(email == '' || active == '0')
		continue;

	// reviewed
	num_reviewed[name] = reviewed;

	// email
	name_to_email[name] = email;
	
	// if there is no level, default to pri
	if(level == '')
		level = "pri"
	// if this level does not exist yet
	if(!(level in subject_to_name))
		subject_to_name[level] = {};

   for(var k = 0; k < subject.length; k++){  
		if(subject[k] == '')
			break;

		// special case for chinese
		if(containsSubstring(subject[k], 'chinese'))
			subject[k] = 'chinese';

		if(!(subject[k] in subject_to_name[level])){
			subject_to_name[level][subject[k]] = [];
		}
		subject_to_name[level][subject[k]].push(name);
	}
}

// console logging for clarity
console.log("List of available of subjects by level:");
for(lvl in subject_to_name){
	console.log(lvl + ": ");
	for(sub in subject_to_name[lvl]){
		console.log('\t' + sub);
	}
}
console.log('------------');

////////////////////////////////////////////////////////

// CREATING DATE

var date_offset = 5; // (current day + 5 working days) HBL change to 3

var due_date = new Date(Date.now()), cur_date = new Date(Date.now());

cmd_msg = '\n---------PLEASE REVIEW THE FOLLOWING MESSAGES---------\n';

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

////////////////////////////////////////////////////////

// ASSIGNING TEACHER AND DATES

// the purpose of 'history' array is to locate the latest non-similar item by a teacher.
var latest = {};
//pending is all the SLS data 
for(var i = 0; i < pending.length; i++){

	// getting the data
	var row = pending[i]; // define row for ease of writing in row instead of pending

	var sn = row[0], subject = row[3].trim().toLowerCase(); // .trim() remove blanks spaces
	var author = row[7].trim().toLowerCase(), title = row[1].trim().toLowerCase(); //.toLowerCase() in preparation of issues of upperCase etc
	var similar = row[9], resubmitted = row[10];
	var duplicate = 0, similar_to = '';

	// reducing the level of the lesson to either 'pri', 'sec', or 'jc'
	var level = row[4].trim().toLowerCase();
	if(containsSubstring(level, "sec")){
		level = "sec";
	}
	else if(containsSubstring(level, "jc") || containsSubstring(level, "college") || containsSubstring(level, "pre-u")){
		level = "jc";
	}
	// if cannot identify the level as sec or jc, default to pri
	else{
		level = "pri";
	}

	var admin_assigned = 1, recipient_name = '';

	if(similar == 1){
		// check for duplicates
		// searches through the previous items to find a similar item
		for(var k = 0; k < i; k++){
			var cur_title = pending[k][1].trim().toLowerCase(), cur_author = pending[k][7].trim().toLowerCase();
			if(cur_title == title && cur_author == author){
				duplicate = 1;
				cmd_msg += 'ALERT: Item ' + sn + ' is detected as duplicate, admin not assigned. Please return duplicate lesson (you should be able to see from SLS CG admin page) first and rerun tagui file\n';
				admin_assigned = 0;
				break;
			}
		}

		if(!duplicate){
			//We assume that lessons marked as 'similar' is similar to the latest lesson submitted by the teacher.
			if(!(author in latest)){
				cmd_msg += 'ERROR: Item ' + sn + ' has been marked as "similar", but cannot identify which item it is similar to, admin not assigned.\n';
				admin_assigned = 0;
			}
			else{
				similar_idx = latest[author];
				// console.log(similar_idx)
				// writing the title of the similar item to the similar_to column
				similar_to = pending[similar_idx - 1][1];

				// assigning same admin
				recipient_name = pending[similar_idx - 1][11];
				num_reviewed[recipient_name]++;
				
				cmd_msg += 'ALERT: Item ' + sn + ' has been marked as "similar" to item ' + similar_idx + ', same admin assigned.\n';
			}
		}	
	}

	else{
		latest[author] = sn;
		// NOTE: Due to inconsistency in subjects between email and pending tables, this is necessary to find the correct admins
		// HOWEVER, IN THE EVENT THAT IT IS UNABLE TO CAPTURE THE SUBJECT, PLEASE MANUALLY FILL IT IN THE CSV FILE

		var attempt_counter = 1, subject_found = subject_to_name[level].hasOwnProperty(subject), orig_level = level;
		while(!subject_found){
			// loops through all the available subjects listed in emails.csv
			for(sub in subject_to_name[level]){
				// unique cases
				if(sub == 'd&t' && containsSubstring(subject, "design & technology")){
					subject = 'd&t';
					subject_found = true;  
				}
				else if(sub == 'pe' && containsSubstring(subject, "physical education")){
					subject = 'pe';
					subject_found = true;
				}
				
				// test for acronyms
				//checks for the acronyms 'pe' and 'd&t' in the subject name
				// to prevent FORM TEACHER GUIDANCE PERIOD being match to pe
				if(sub == 'pe' || sub == 'd&t'){
					//checks if there is a space to the left and to the right of the acronym
					var regex = new RegExp("(?:\\s|^)" + sub + "(?:\\s|$)", "gi");
					//https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/RegExp/test
					// test if subject contains regex
					if(regex.test(subject)){
						// if true assign sub into subject
						subject = sub;
						subject_found = true;
					}
				}
				// for eg, if subject = "additional mathematics" and sub = "math"  
				// or, if sub = 'chinese language', and subject = 'chinese'
				else if(containsSubstring(subject, sub) || containsSubstring(sub, subject)){
					subject = sub;
					subject_found = true;
				}

				if(subject_found){
					break;
				}
			}
			// break out of while loop if subject has been found, or already attempted all 3 levels
			if(subject_found || attempt_counter >= 3){
				break;
			}

			// if the current level did not suffice, attempt to grab admins from other levels instead
			if(level == "pri"){
				level = "sec";
			}
			else if(level == "sec"){
				level = "jc";
			}
			else{
				level = "pri";
			}
			attempt_counter++;
		}
		
		// error message if subject is not found
		if(!subject_found){
			cmd_msg += 'ERROR: Item '+ sn +': Cannot find subject "'+subject+'" at all levels, admin not assigned. You are encouraged to self review and quickly publish it or return it, then rerun tagui \n';
			admin_assigned = 0;
		}
		else{
			// warning message if assigned lesson to an admin of a different level then the original
			if(attempt_counter > 1){
				cmd_msg += 'ALERT: Item '+ sn +': Cannot find subject "'+subject+'" at "'+orig_level+'" level, assigned admin at "'+level+'" level instead.\n';
			}

			// ASSIGNING RECIPIENT 
			// sorting to get person with the lowest number of reviewed items
			subject_to_name[level][subject].sort(function(a, b){
				return num_reviewed[a] - num_reviewed[b];
			});

			recipient_name = subject_to_name[level][subject][0];

			num_reviewed[recipient_name]++;
		}
	}
	
	// cannot find duplicate, or cannot find similar item, or cannot find subject
	if(!admin_assigned)
		pending[i] = pending[i].concat(['', '', '', duplicate, similar_to, '']);
	else
		pending[i] = pending[i].concat([recipient_name, formatDate(cur_date), formatDate(due_date), duplicate, similar_to, name_to_email[recipient_name]]);
}

// this code if the file pendingreview_list.csv is not created will cause an error ,ERROR - Unable to remove file '/Users/lookang/Desktop/tagui/flows/lookang/20210707/pendingreview_list.csv' correct?
//var fs = require('fs');
//fs.move("pendingreview_list.csv", "folder/pendingreview_list.csv");

js finish
// WRITING TO FILE , Create if missing, replace if present
dump ["S/N", "Title", "Type", "Subject", "Level", "School", "Date Submitted", "Author", "URL", "Similar", "Resubmitted", "Assigned To", "Date Lesson Assigned", "Due Date", "Duplicate", "Similar To", "Email of Admin"])` to pendingreview_list.csv

// WRITING TO FILE
//write `csv_row(["S/N", "Title", "Type", "Subject", "Level", "School", "Date Submitted", "Author", "URL", "Similar", "Resubmitted", "Assigned To", "Date Lesson Assigned", "Due Date", "Duplicate", "Similar To", "Email of Admin"])` to pendingreview_list.csv

for i from 1 to pending.length
	write `csv_row(pending[i - 1])` to pendingreview_list.csv
	// to debug and see what is happening in pending 
	// js console.log(pending[i-1])

echo `cmd_msg`



wait 5

