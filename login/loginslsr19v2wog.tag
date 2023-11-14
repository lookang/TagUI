//INSTALLATION
// https://tagui.readthedocs.io/en/latest/setup.html


//Enter in to SLS login page
https://vle.learning.moe.edu.sg/login

echo login yourself as requested to overcome slow WOG either SLS or MIMS is both fine
live

// https://vle.learning.moe.edu.sg/mrv/community-gallery/admin // old R18
https://vle.learning.moe.edu.sg/community-gallery/admin?resource=LESSON&location=COMMUNITY_GALLERY&status=PENDING_APPROVAL

wait 10

if present ('walkme-custom-balloon-content')
	click walkme-custom-balloon-button walkme-custom-balloon-weak-button walkme-custom-balloon-cancel-button walkme-action-cancel walkme-click-and-hover

//sort back to first in, at the bottom like in R18
click Date Submitted
click Date Submitted
// click twice to get in the order

// getting total_number of rows
if present('//div[@class="v-data-footer__pagination"]')
	read //div[@class="v-data-footer__pagination"] to pagination
	js total = parseInt(pagination.split("of")[1].trim());
	echo There are `total` number of lessons.
else
	echo you have no lessons to review! hurray

echo to allow admin to check first the pending review list, type done to exit and continue flow
live

// getting total_number of rows
read //div[@class="v-data-footer__pagination"] to pagination
js total = parseInt(pagination.split("of")[1].trim());
echo after reviews, There are `total` number of lessons.


ask Check SLS CG pending review for the number of lessons. Key in 0 for all lessons extraction, or the starting number of lesson to start data extraction ?
echo `ask_result`
if ask_result equals to '0'
	rowCnt = 1
else 
	rowCnt = Math.floor(ask_result,20) 
	echo checking `rowCnt` 

wait 3
// creating row counter so that it can loop through the table properly

//rowCnt = 1
// might want to change this to save time crawling all the assigned
tableCnt = 0
//tableCnt = 1
//tableCnt = 2
//tableCnt = 3
//tableCnt = 4

// loop to skip the specified number of tables
// due to change in CG page no need to click Next anymore, page stays the same
for i from 1 to tableCnt
	// click //button[@aria-label="Next page"]

pending = []

// always in groups of 20 now in UI
for i from 1 to (total-tableCnt*20)
	
	// trying to break out if total is not found 
	//if (exist('//*[@id="pending"]//table/tbody/tr[`rowCnt`]/td[1]/div/div/span'))
	if (exist('//*[@id="main-content"]/div/div/section/div/div[2]/div[2]/div/div[1]/table/tbody/tr[`rowCnt`]/td[1]/div/div/span/span'))
		read //*[@id="main-content"]/div/div/section/div/div[2]/div[2]/div/div[1]/table/tbody/tr[`rowCnt`]/td[1]/div/div/span/span to title
		echo `title`
		read //*[@id="main-content"]/div/div/section/div/div[2]/div[2]/div/div[1]/table/tbody/tr[`rowCnt`]/td[2]/div/span to type
		read //*[@id="main-content"]/div/div/section/div/div[2]/div[2]/div/div[1]/table/tbody/tr[`rowCnt`]/td[3]/div/div/div/span to subject
		read //*[@id="main-content"]/div/div/section/div/div[2]/div[2]/div/div[1]/table/tbody/tr[`rowCnt`]/td[4]/div/span to level
		read //*[@id="main-content"]/div/div/section/div/div[2]/div[2]/div/div[1]/table/tbody/tr[`rowCnt`]/td[5]/div/span to school
		read //*[@id="main-content"]/div/div/section/div/div[2]/div[2]/div/div[1]/table/tbody/tr[`rowCnt`]/td[8]/div/span[1] to datesubmitted
		read //*[@id="main-content"]/div/div/section/div/div[2]/div[2]/div/div[1]/table/tbody/tr[`rowCnt`]/td[8]/div/span[2] to author

	else
		break
	

	// trimming the author string to remove the 'By '
	js author = author.slice(3);
	// css path to the first column in the row
	//dom_json = {css_path: "#main-content > tbody > tr:nth-child(" + rowCnt + ") > td:nth-child(1) > div "}
	//js console.log(dom_json)
	similar = 0
	if (exist ('//*[@id="main-content"]/div/div/section/div/div[2]/div[2]/div/div[1]/table/tbody/tr[`rowCnt`]/td[1]/div/button/span'))
		read //*[@id="main-content"]/div/div/section/div/div[2]/div[2]/div/div[1]/table/tbody/tr[`rowCnt`]/td[1]/div/button/span to b
		echo `b`
		if (b equals to 'This resource is similar to another resource submitted to the Community Gallery.')
			similar = 1
		else
			similar = 0
	// checking for the 'similar' icon
	// dom return document.querySelector(dom_json.css_path + " > button.cv-tooltip") ? 1 : -1
	// similar = dom_result == -1 ? 0 : 1
	// echo similar = `similar`
	

	// checking for the 'resubmitted' label
	// dom return document.querySelector(dom_json.css_path + "span[title='Resubmitted']") ? 1 : -1
	// resubmit = dom_result == -1 ? 0 : 1
	// echo resubmit = `resubmit`
	resubmit = 0
	if (exist ('//*[@id="main-content"]/div/div/section/div/div[2]/div[2]/div/div[1]/table/tbody/tr[`rowCnt`]/td[1]/div/div/div/span'))
		read //*[@id="main-content"]/div/div/section/div/div[2]/div[2]/div/div[1]/table/tbody/tr[`rowCnt`]/td[1]/div/div/div/span to a
		echo `a`
		if (a equals to 'Resubmitted')
			resubmit = 1
			//echo checking why lesson 11 is not resubmiited
			//live
		else
			resubmit = 0
	link = ""
	// lessons marked as similar will not have an accessible url in SLS
	if (similar == 0)
		{
		wait 3
		echo trying to click OPEN
		click //*[@id="main-content"]/div/div/section/div/div[2]/div[2]/div/div[1]/table/tbody/tr[`rowCnt`]/td[1]/div/div/a
		echo managed to click on the link OPEN
		//wait 3
		wait 8

	
		
		// popup cover
		// strangely can have lesson https://vle.learning.moe.edu.sg/community-gallery/admin/lesson/view/417a1bcf-d631-4205-b3f5-d94ed2a8418e/page/67738538
		// without the word cover is the URL, changing to use lesson/view/
		popup lesson/view/
		{
		//live
		wait 1 
		js link = url()
		// read the title
		// read output-text to title
		// echo `title`
		echo `link`
		dom window.close()
		}
		
		js link = link.substring(8)
		https://`link`
		read output-text to title
		echo new title is `title`
		dom window.history.back()
		//sort back to first in, at the bottom like in R18
		click Date Submitted
		click Date Submitted

		//wait 3
		
		// 	https://vle.learning.moe.edu.sg/mrv/community-gallery/admin
		// remove this line as SLS R19 popup a new page so the first page always unchanged after sorting
		// https://vle.learning.moe.edu.sg/community-gallery/admin?resource=LESSON&location=COMMUNITY_GALLERY&status=PENDING_APPROVAL

		echo line 209

		for j from 1 to tableCnt
			click //button[@aria-label="Next page"]
			//wait 3 // assuming WOG is slow, problem reported on 20230814
			
		}
	// pending is an array collection of different variables
	js pending.push([i, title, type, subject, level, school, datesubmitted, author, link, similar, resubmit])
	echo `pending`
	js rowCnt++;
	if (rowCnt == 21)
		{
		click //button[@aria-label="Next page"]
		js tableCnt++; // maybe TagUI code has no ++ so use js
		echo tableCnt = `tableCnt`
		rowCnt = 1
		wait 2
		}
	

///////////////////// ASSIGNING TEACHERS AND DATES /////////////////////
// admin_table is a TagUI code
// maybe TagUI can do it well, so using js to convert ot nice table of rows and columns
//load emails.csv to admin_table
load 2023 CG Admin Subjects and Emails - CG Admin emails.csv to admin_table
// trying to convert to xlsx use instead of csv 
//admin_table =[Subject Grps for Tracking_05Feb.xlsx]emails!A:Q
echo `admin_table`

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
			//console.log("line 329 break")

		// special case for chinese
		if(containsSubstring(subject[k], 'chinese'))
			subject[k] = 'chinese';

		if(!(subject[k] in subject_to_name[level])){
			subject_to_name[level][subject[k]] = [];
			//console.log("line 337 what does it do?")
		}
		subject_to_name[level][subject[k]].push(name);
		//console.log("line 340 push what does it do?")
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
				// may not be needed as physical education is spelled in full now in csv 
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

