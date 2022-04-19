// TagUI script written by Shaun Quek and Loo Kang Wee 
// dated 20210630
// for automation of posting questions in MCQ and Free response to SLS R15

//prepare output.csv from pptx to csv into body
load output.csv to body
//echo `body`
// prepare data cleaning into usable form 




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

// load questions_csv 
questions_csv = CSVToArray(body);
//window.print( question_csv = `question_csv`)
//setTimeout(alert("30 seconds"),30000);
questions = [];
for(var z = 1; z < questions_csv.length; z++){
	var row = questions_csv[z];
	var qn = {
		// actually columns , row[7] is question in output.csv 01234567
		question: row[7],
		// row[8] is answer in output.csv 012345678
		answer: row[8],
		//initialises qn.options to be an empty array at first
		options : []
	}
	// looping through the options in the csv, the next few lines populate the array (if the qn is mcq)
	for(var i = 9; i < 13; i++){
		//https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/Trim remove whitespace if any
		if(row[i].trim() != '') // not blank
			// do this
			qn.options.push(row[i]);
	}
	questions.push(qn);
	// just to see the qn.options 
	console.log(qn.options);
	//prompt()
}

js finish

//echo questions_csv is `questions_csv`
echo questions is `questions`

//Enter in to SLS
//visit URL
https://vle.learning.moe.edu.sg/mrv/community-gallery/admin

//assume no need to extra login
if present('button login bx--btn bx--btn--primary')
	click .button.login
	wait 5
	// this email is linked to your SLS alternative email for OTP, change this accordingly
	// need to change in SLS the alternative email for the OTP
	ask Key in 1 for gmail or 2 or anything else for icon email with OTP
	echo `ask_result`
	if ask_result contain '1'
		https://mail.google.com/mail/u/0/#inbox"
	else 
		https://mail.google.com/mail/u/1/#inbox
	
	
	// Click Sign in 
	wait 5
	// click the first email by notifications@sls.ufinity.com in the table
	click //*[@email="notifications@sls.ufinity.com"]/ancestor-or-self::tr
	//code = ""
	if ask_result contain '1'
		read //div[7]/div[3]/div/div[2]/div[1]/div[2]/div/div/div/div/div[2]/div/div[1]/div/div[2]/div/table/tr/td[1]/div[2]/div[2]/div/div[3]/div/div/div/div/div/div[1]/div[2]/div[3]/div[3]/div/div[2]/h2 to code
	else
		read /html[1]/body[1]/div[7]/div[3]/div[1]/div[2]/div[1]/div[2]/div[1]/div[1]/div[1]/div[1]/div[2]/div[1]/div[1]/div[1]/div[3]/div[1]/table[1]/tr[1]/td[1]/div[2]/div[2]/div[1]/div[3]/div[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[2]/div[3]/div[3]/div[1]/div[2]/h2[1] to code
	echo `code`
	wait 5

	// go back to SLS
	https://vle.learning.moe.edu.sg/mrv/community-gallery/admin
	type otp as `code`
	click .field-set.type-button.otp-submit button
	wait 5 

//wait 5 //to load the SLS page correctly first before next step

///////////////////////////////////

https://vle.learning.moe.edu.sg/mrv/my-library/owned-by-me
// click on ADD NEW button to start lesson creation process
click Add New 
click bx--overflow-menu-options__option-content

//click on Choose Lesson or Course and click Lesson
click card-footer _vertical

//click on Choose Lesson Template and click Custom
click card-footer _vertical

// type Lesson Title
type bx--text-input as [clear]D2.2_Decimal
//save icon 
click cv-button bx--btn bx--btn--primary bx--btn--icon-only

// +ADD ACTIVITY
//click cv-button add-activity bx--btn bx--btn--tertiary
click cv-button tooltip-button add-activity bx--btn bx--btn--tertiary
// Add New Activity - Custom Activity
//click /html/body/div[3]/div/div/div[2]/div/div[4]/div[1]/div[3]/a
click Custom Activity

// type Activity Title
type bx--text-input as [clear]D2.2_Decimal[enter]
//save icon 
click cv-button bx--btn bx--btn--primary bx--btn--icon-only

// declare a question counter =1
qn_cnt = 1
for i from 1 to questions.length
	qn = questions[i - 1]
	// we notice the loop element starts at qn_cnt = 2  
	qn_cnt = qn_cnt + 1

	// +ADD COMPONENT
	click cv-button add-component bx--btn bx--btn--tertiary bx--btn--field

	if (qn.options.length > 0)
		// use the option length as a condition for MCQ 
		click Multiple-Choice 
		// Enter the question
		click /html/body/div[1]/main/div/div/div/section[1]/div[2]/div/div/div[`qn_cnt`]/div/div/div/div/div/div/div[2]/div/div/div/div/form/dl[2]/dd/div/div[2]/div
		type paragraph as `qn.question`

		// Adding the options +ADD OPTIONS cos SLS default is 2 options, so need to add qn.options.length=4 -2 , = 2 more depending on the qn.options.length
		add_cnt = qn.options.length - 2
		for j from 1 to add_cnt
			click cv-button add-option bx--btn bx--btn--tertiary bx--btn--field

		// Filling in the options
		for j from 1 to qn.options.length
			click /html/body/div[1]/main/div/div/div/section[1]/div[2]/div/div/div[`qn_cnt`]/div/div/div/div/div/div/div[2]/div/div/div/div/form/dl[5]/dd/div/div/div[`j`]/label/span[2]/div/div[1]/div[2]/div
			type paragraph as `qn.options[j - 1]`

		// Selecting the correct option
		click //div[@class="input-radio"][`qn.answer`]//span[@class="input-icon"]
	
		// Saving
		click cv-button bx--btn bx--btn--primary bx--btn--icon-only
	else
		// assume else is Free-Response
		//click component menu
		click cv-button add-component bx--btn bx--btn--tertiary bx--btn--field
		
		//select option FR 
		click Free-Response
		// Enter the question
		//click /html/body/div[1]/main/div/div/div/section[1]/div[2]/div/div/div[`qn_cnt`]/div/div/div/div/div/div/div[2]/div/div/div/div/form/dl[2]/dd/div/div[2]/div
		//click /html/body/div[1]/main/div/div/div/section[1]/div[2]/div/div/div[1]/div/div/div/div/div/div/div[2]/div/div/div/div/form/dl[2]/dd/div/div[2]/div
		//click /html/body/div[1]/main/div/div/div/section[1]/div[2]/div/div/div[2]/div/div/div/div/div/div/div[2]/div/div/div/div/form/dl[3]/dd/div/div[2]
		click /html/body/div[1]/main/div/div/div/section[1]/div[2]/div/div/div[`qn_cnt`]/div/div/div/div/div/div/div[2]/div/div/div/div/form/dl[3]/dd/div/div[2]/div
		type paragraph as `qn.question`

		// Enter the answer
		click /html/body/div[1]/main/div/div/div/section[1]/div[2]/div/div/div[`qn_cnt`]/div/div/div/div/div/div/div[2]/div/div/div/div/form/dl[6]/dd/div/div[2]/div[1]/dl/dd/div/div[2]/div
		//click /html/body/div[1]/main/div/div/div/section[1]/div[2]/div/div/div[3]/div/div/div/div/div/div/div[2]/div/div/div/div/form/dl[6]/dd/div/div[2]/div[1]/dl/dd/div/div[2]
		type paragraph as `qn.answer`

		// Saving
		//click //div[@class="input-radio"][`qn.answer`]//span[@class="input-icon"]
		//click cv-tooltip bx--tooltip__trigger bx--tooltip--a11y bx--tooltip--bottom bx--tooltip--align-center
		click cv-button bx--btn bx--btn--primary bx--btn--icon-only

// final save tick
click cv-header-global-action bx--header__action