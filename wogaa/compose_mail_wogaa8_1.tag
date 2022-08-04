//YouTube https://www.youtube.com/watch?v=wgPiQcj-DvY
//GitHub https://github.com/lookang/TagUI/blob/main/wogaa/compose_mail_wogaa8_1.tag


// type 
//tagui update in cmd to get the latest bug fix for mac csv width
//Downloading and updating to latest version of TagUI (v6.110)
//TagUI successfully updated at //Users/lookang/Desktop/tagui 
// https://www.youtube.com/watch?v=NV9b-pOBggo
// step 0: install Tagui from https://tagui.readthedocs.io/en/latest/setup.html 
// step 0.5: Windows recommended https://github.com/kelaberetiv/TagUI/releases/download/v6.46.0/TagUI_Windows.exe 
// step 1: download *.csv into the tagui folder example: /Users/lookang/Desktop/tagui/flows/wogaa or c:/rpa/tagui/flow/wogaa depending on Mac or Windows
// utf-8 support chinese character is automatically understood using javascript and load tagui
// step 2: navigate in cmd or terminal to the folder say cd /Users/lookang/Desktop/tagui/flows/wogaa/ or cd c:/rpa/tagui/flow/wogaa/
// step 3: using code editor example VS code to edit the line on filename to the correct file
// step 4: using cmd type: tagui compose_mail_wogaa6csv.tag
// code to run in cmd
// normal speed
// tagui compose_mail_wogaa5csv.tag
//FINISH - automation finished - 1052.7s for 59 emails
// 
// prepration need to do once only to prepare the TagUI chrome browser with login and password
// type in cmd: tagui live 
// use the TagUi chrome browser to login and password to your gmail to send emails out using the RPA, this is invisible in the code and only the browser knows so it is safe.
// now you can run step 4:
// step 4b: tagui compose_mail_wogaa6csv.tag -turbo
//or experimental, super human speed
// tagui compose_mail_wogaa5csv.tag -turbo
//FINISH - automation finished - 159.5s for 59 emails

//live

// erase file
//var fs = require('fs');
//fs.remove('/Users/lookang/Desktop/tagui/flows/wogaa/singapore_student_learning_space_(sls)-daily-24_07_2022.csv');

ask What is the date to be processed ( in DD_MM_YYYY for example 27_07_2022)
//ask What
echo `ask_result`
//https://www.w3schools.com/jsref/jsref_replace.asp
// built in extra features to autocorrect to _
js temp_underscore = ask_result.replace(/-/g, "_");
//js temp = "singapore_student_learning_space_(sls)-daily-"+ask_result
js temp = "singapore_student_learning_space_(sls)-daily-"+temp_underscore
echo temp = `temp`
//expect temp = singapore_student_learning_space_(sls)-daily-02-08-2022
// may need to edit manually
//filename = "singapore_student_learning_space_(sls)-daily-27_07_2022"
filename ="singapore_student_learning_space_(sls)-daily-"+temp_underscore
echo filename = `filename`
// expect filename = singapore_student_learning_space_(sls)-daily-02-08-2022

//https://www.w3schools.com/jsref/jsref_substring.asp
js temp_month = ask_result.substring(3, 5);

echo temp_month = `temp_month`
// expect temp_month = 08

js begin
//https://stackoverflow.com/questions/1643320/get-month-name-from-date
monthNames = ["AAA","Jan", "Feb", "Mar", "Apr", "May", "Jun",
  "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
];
js finish

js temp_month_words = monthNames[parseInt(temp_month)]
echo temp_month_words = `temp_month_words`
// expect temp_month_words = Aug

// reconstruct back
js fullmonth = ask_result.substring(0,2)+"-" + temp_month_words +"-" +ask_result.substring(6)
echo fullmonth = `fullmonth`

//ask What is the date to be processed? ( in DD-Mmm-YYYY , for example 27-Jul-2022)
//echo `ask_result`
//js temp = "file:///Users/lookang/Desktop/tagui/flows/wogaa/daily-sentiments-report-"+ask_result+"-singapore-student-learning-space-sls.html"
//keyboard `ask_result`
//js temp = "file:///Users/lookang/Desktop/tagui/flows/wogaa/daily-sentiments-report-"+fullmonth+"-singapore-student-learning-space-sls.html"

//ask type this in the prompt `temp`
//echo `ask_result`
//using computer vision engine, must be on primary monitor display
// make sure all java icon on bottom right corener are closed, due to active engine not closed
// about_blank_using_tagui_snap.png 
// snap (144,71)-(221,91) to about_blank_using_tagui_snap.png

os = require('system').os.name
echo os = `os`
//live
//home_dir = get_env('HOME')
//if home_dir contains "/Users/"
if os contains "mac"
	//echo `home_dir` assume Users is unique to Mac and not Windows
	echo recent Chrome version updated to Version 104.0.5112.79 (Official Build) (x86_64) cause a need to re snap the a.png
	dclick a.png
	js temp = "file:///Users/lookang/Desktop/tagui/flows/wogaa/daily-sentiments-report-"+fullmonth+"-singapore-student-learning-space-sls.html"
else
	echo assume Windows as would not contains mac text
	dclick about_window.png
	js temp =  "file:///C:/rpa/tagui/flows/wogaa/daily-sentiments-report-"+fullmonth+"-singapore-student-learning-space-sls.html"



//live
//may need to edit manually if wrongly asked the date
//keyboard [clear] file:///Users/lookang/Desktop/tagui/flows/wogaa/daily-sentiments-report-27-Jul-2022-singapore-student-learning-space-sls.html [enter]

keyboard [clear] `temp` [enter]
//live


// note something there could be errors in data, need to maually go to excel and clean the data up to remove 
//skip 392 ERROR - undefined is not an object (evaluating 'cell_data.toString')
// the data is üëçüëçüëçüëçüëçüëç

//ask paste file:///Users/lookang/Desktop/tagui/flows/wogaa/daily-sentiments-report-24-Jul-2022-singapore-student-learning-space-sls.html into the browser yourself
// file:///Users/lookang/Desktop/tagui/flows/wogaa/daily-sentiments-report-24-Jul-2022-singapore-student-learning-space-sls.html
click Export to CSV 
click All Services
// file created

// need time for file to be found
wait 3
load `filename`.csv to body_1
echo `body_1`
//create name of different _1 for debugging
dump  `([ 'DataTime', 'ServiceName','TXNID','PageURL', 'BrowserVersion','OSDevice','Geographic','Rating','EmailAddress','Name','MessageTitle','GotContent' ])` to `filename`_1.csv
write `body_1` to `filename`_1.csv

click Ratings 4 & below
click /html/body/div/div[2]/div/div[2]/div/div[1]/div[2]/div/div/span/button
click /html/body/div/div[2]/div/div[2]/div/div[1]/div[2]/div/div[2]/div/div/a[1]
// second file created with same name
// default name of file after export is
wait 3
load `filename`.csv to body_2
echo `body_2`
// create blank file
dump `([ 'DataTime', 'ServiceName','TXNID','PageURL', 'BrowserVersion','OSDevice','Geographic','Rating','EmailAddress','Name','MessageTitle','GotContent' ])` to `filename`_2.csv
write `body_2` to `filename`_2.csv
//live

//delete exisiting data
dump `([ 'DataTime', 'ServiceName','TXNID','PageURL', 'BrowserVersion','OSDevice','Geographic','Rating','EmailAddress','Name','MessageTitle','GotContent' ])` to `filename`.csv
//combine
//write `body1` to singapore_student_learning_space_(sls)-daily-24_07_2022.csv
write `body_1` to `filename`.csv
write `body_2` to `filename`.csv
load `filename`.csv to bodyfull
echo `bodyfull`



filedate = filename.substring(45, 65)
column_A = [`filename`.csv]singapore_student_learning_spac!A:A
//echo `column_A`
filelength = column_A.length
echo filelength = `filelength`
column_A_1 = [`filename`_1.csv]singapore_student_learning_spac!A:A
//echo `column_A`
filelength_1 = column_A_1.length

column_A_2 = [`filename`_2.csv]singapore_student_learning_spac!A:A
//echo `column_A`
filelength_2 = column_A_2.length
echo filelength_2 = `filelength_2`

//-------------------------------------------
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

pendingfull = CSVToArray(bodyfull);
pending_1 = CSVToArray(body_1);
pending_2 = CSVToArray(body_2);
//declare as arrays
MessageTitlefull =[]
MessageBodyfull =[]
EmailAddressfull =[]
Namefull = []

MessageTitle_1 =[]
MessageBody_1 =[]
EmailAddress_1 =[]
Name_1 = []

MessageTitle_2 =[]
MessageBody_2 =[]
EmailAddress_2 =[]
Name_2 = []


var start =1 
for(var k = start; k < pendingfull.length; k++){
//for(var k = start_from_sn; k < 2; k++){
////console.log(pending[1]);
//console.log(pending[2]);
row = pendingfull[k];

//console.log("row = "+ row);
//DateTime[k] = row[0] 
//console.log("DateTime = " +DateTime[k]);
// DateTime = 13/6/22 21:26
//ServiceName[k] = row[1]
//TXNID[k] = row[2]
//PageURL[k] = row[3]
////BrowserVersion[k] = row[4]
//OSDevice[k] = row[5]
//Geographic[k] = row[6]
//Rating[k] = row[7]
// note that 202206 script is in this order email,name,title, body
// 20220724 order is body,title,name, email reverse, but it should not matter in email sent
EmailAddressfull[k] = row[8]
//console.log("EmailAddress = " +EmailAddressfull[k]);
// EmailAddress = 瑞恩@xxxxx.com
Namefull[k] = row[9]
MessageTitlefull[k] = row[10]
MessageBodyfull[k] = row[11]
// M is blank
//N is unused
//GotContent[k] = row [14]
}

var start_1 =1 
for(var k = start_1; k < pending_1.length; k++){
//for(var k = start_from_sn; k < 2; k++){
////console.log(pending[1]);
//console.log(pending[2]);
row_1 = pending_1[k];

//console.log("row = "+ row);
//DateTime[k] = row[0] 
//console.log("DateTime = " +DateTime[k]);
// DateTime = 13/6/22 21:26
//ServiceName[k] = row[1]
//TXNID[k] = row[2]
//PageURL[k] = row[3]
////BrowserVersion[k] = row[4]
//OSDevice[k] = row[5]
//Geographic[k] = row[6]
//Rating[k] = row[7]
// note that 202206 script is in this order email,name,title, body
// 20220724 order is body,title,name, email reverse, but it should not matter in email sent
EmailAddress_1[k] = row_1[8]
//console.log("EmailAddress = " +EmailAddress_1[k]);
// EmailAddress = 瑞恩@xxxxx.com
Name_1[k] = row_1[9]
MessageTitle_1[k] = row_1[10]
MessageBody_1[k] = row_1[11]
// M is blank
//N is unused
//GotContent[k] = row [14]
}

var start_2 =1 
for(var k = start_2; k < pending_2.length; k++){
//for(var k = start_from_sn; k < 2; k++){
////console.log(pending[1]);
//console.log(pending[2]);
row_2 = pending_2[k];

//console.log("row = "+ row);
//DateTime[k] = row[0] 
//console.log("DateTime = " +DateTime[k]);
// DateTime = 13/6/22 21:26
//ServiceName[k] = row[1]
//TXNID[k] = row[2]
//PageURL[k] = row[3]
////BrowserVersion[k] = row[4]
//OSDevice[k] = row[5]
//Geographic[k] = row[6]
//Rating[k] = row[7]
// note that 202206 script is in this order email,name,title, body
// 20220724 order is body,title,name, email reverse, but it should not matter in email sent
EmailAddress_2[k] = row_2[8]
//console.log("EmailAddress = " +EmailAddress_2[k]);
// EmailAddress = 瑞恩@xxxxx.com
Name_2[k] = row_2[9]
MessageTitle_2[k] = row_2[10]
MessageBody_2[k] = row_2[11]
// M is blank
//N is unused
//GotContent[k] = row [14]
}




js finish
//-------------------------------------------

//  with data in case other people need the old file data
dump `([ 'DataTime', 'ServiceName','TXNID','PageURL', 'BrowserVersion','OSDevice','Geographic','Rating','EmailAddress','Name','MessageTitle','GotContent' ])` to  `filename`_filtered.csv
start = 1
for i from start to filelength-1
	if EmailAddressfull[i] equals to "" or Namefull[i] equals to "" or MessageTitlefull[i] equals to "" or MessageBodyfull[i] equals to ""
		echo skip `i`
	else 
		write `csv_row(pendingfull[i])` to `filename`_filtered.csv
		echo `pendingfull[i]`

// to create separate file_1 for ease of implementing simple loops with data
dump `([ 'DataTime', 'ServiceName','TXNID','PageURL', 'BrowserVersion','OSDevice','Geographic','Rating','EmailAddress','Name','MessageTitle','GotContent'])` to  `filename`_1_filtered.csv
start = 1
for i_1 from start to (filelength_1-2)
	if EmailAddress_1[i_1] equals to "" or Name_1[i_1] equals to "" or MessageTitle_1[i_1] equals to "" or MessageBody_1[i_1] equals to ""
		echo skip `i_1`
	else 
		write `csv_row(pending_1[i_1])` to `filename`_1_filtered.csv
		echo `pending_1[i_1]`



// to create separate file_2  for ease of implementing simple loops with data
dump `([ 'DataTime', 'ServiceName','TXNID','PageURL', 'BrowserVersion','OSDevice','Geographic','Rating','GotContent','MessageTitle' ,'Name','EmailAddress' ])` to  `filename`_2_filtered.csv
start = 1
echo filelength_2 = `filelength_2`
for i_2 from start to (filelength_2-2)
	if EmailAddress_2[i_2] equals to "" or Name_2[i_2] equals to "" or MessageTitle_2[i_2] equals to "" or MessageBody_2[i_2] equals to ""
		echo skip `i_2`
	else 
		write `csv_row(pending_2[i_2])` to `filename`_2_filtered.csv
		echo `pending_2[i_2]`
