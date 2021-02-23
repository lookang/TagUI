load body_template.txt to body
load pendingreview_list.csv to pending_table
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

////////////////////////////////////////////////////////

// LINKING THE NAME TO THE EMAIL 
// NOTE: variables with 'var' will not be accessible outside this javascript code block
name_to_email = {};

var admin_info = CSVToArray(admin_table);
for(var i = 0; i < admin_info.length; i++){
	if(i == 0)
		continue
	var row = admin_info[i];
	
	var name = row[1].trim(), email = row[8].trim();
	var reviewed = row[9].trim() == '' ? 0 : row[9];
	var active = row[10].trim();

	// if there is no registered email or the person is not active
	if(email == '' || active == '0')
		continue;

	// name to email
	// eg. name_to_email['person1'] which give the email of person1
	name_to_email[name] = email;
}

////////////////////////////////////////////////////////

// GENERATING THE EMAILS

// VARIABLES
recipient_list = []; // will store a unique list of the recipients

// 'emails' object will be in the following format:
// emails = {'recipient1': {subject: ..., table_rows: ...}, 'recipient2': {subject: ..., table_rows: ...}, ...}
emails = {};

var subject_temp = "[For Action: SLS Community Gallery] Lesson Pending Review By "; // add email and date

var no_of_column = 10; // was 8 without similar and resubmitted

var start_from_sn = 1;

error_msg = '\n---------PLEASE REVIEW THE FOLLOWING MESSAGES---------\n';

// CREATING TABLE ROWS
var pending = CSVToArray(pending_table);
for(var i = start_from_sn; i < pending.length; i++){
	// if row is the title, skip current iteration
	if(i == 0)
		continue;

	var row = pending[i];
   	var similar = row[8], resubmitted = row[9];

	// start from a specific sn, and skip similar or resubmitted questions
	if(row[0] < start_from_sn || similar == '1' || resubmitted == '1'){ 
		error_msg += 'ALERT: Item ' + row[0] + ' has been marked as either "similar" or "resubmitted", skipped.\n';
		continue;
	}

	// console logging for clarity
	for(var k = 0; k < 10; k++){
		console.log(row[k]);
	}	
	// checking if recipient exists
	if(row[10] == '' || typeof row[10] == 'undefined'){
		error_msg += "ERROR: Item " + row[0] + ": No recipient found, skipped.\n";
		console.log('------------------');
		continue;
	}
	console.log('------------------');

	var recipient_name = row[10].trim(), recipient_email = name_to_email[recipient_name];
	var due_date = row[12];

	// CREATING THE EMAIL SUBJECT
	// if there isn't an email with this recipient
	if(!emails.hasOwnProperty(recipient_name)){	
		recipient_list.push(recipient_name);

		emails[recipient_name] = {};
		emails[recipient_name].subject = subject_temp + recipient_name + ' Before ' + due_date;
		emails[recipient_name].table_rows = [];
	}

	// Generating the HTML for each table row
	var row_str = '<tr>';
	// for each item, generate a td
	for(var k = 0; k < no_of_column; k++){
		if(k == 0){ // skipping the s/n column
			continue;
		}

		row_str += '<td style="border: 1px solid black">' + row[k] + '</td>';
	}
	row_str += '</tr>';

	// emails[recipient_name].table_rows contain the HTML code for each row in the table
	emails[recipient_name].table_rows.push(row_str); 
}

// CREATING THE BODY MESSAGE (EXLCUDING TABLE ROWS)
var arg = [due_date, 'Mr Lawrence Wee']; // Strings to replace the {} in body message

// replacing the text
var idx = 0;
body = body.replace(/{}/g, function(match){
	if(typeof arg[idx] != "undefined"){
		return arg[idx++];
	}
	else{
		return match;
	}
});

js finish

echo `error_msg`

////////////////////////////////////////////////////////

// Open gmail (assumes that user has already logged in previously)
https://mail.google.com/mail/u/0/#inbox

wait 3

for i from 1 to recipient_list.length
	// Click 'Compose' button
	click Compose
	recipient_name = recipient_list[i - 1]
	
	// Recipient
	type //textarea[@name="to"] as `name_to_email[recipient_name]`

	// Adding CC
	click //span[@role="link"][contains(@data-tooltip, "Add Cc")]
	type //textarea[@name="cc"] as Lawrence_WEE@moe.gov.sg; Jean_Phua@moe.gov.sg

	// Subject
	type //input[@name="subjectbox"] as `emails[recipient_name].subject` 

	// Body
	dom_json = {body: body}
	dom document.querySelector('div[aria-label="Message Body"]').innerHTML = dom_json.body

	// Filling in the rows
	for k from 1 to emails[recipient_name].table_rows.length
		dom_json = {row: emails[recipient_name].table_rows[k - 1]}
		dom document.getElementById("tagui_table").innerHTML += dom_json.row

	// Send Button
	// click //div[@role="button"][contains(@data-tooltip, "Send")]
	wait 5	
    





