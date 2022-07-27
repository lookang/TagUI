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

//using computer vision engine, must be on primary monitor display
// make sure all java icon on bottom right corener are closed, due to active engine not closed
// about_blank_using_tagui_snap.png 
// snap (144,71)-(221,91) to about_blank_using_tagui_snap.png
dclick about_blank_using_tagui_snap.png
//live
keyboard [clear] file:///Users/lookang/Desktop/tagui/flows/wogaa/daily-sentiments-report-24-Jul-2022-singapore-student-learning-space-sls.html [enter]

filename = "singapore_student_learning_space_(sls)-daily-24_07_2022"
// erase file
dump `([ 'DataTime', 'ServiceName','TXNID','PageURL', 'BrowserVersion','OSDevice','Geographic','Rating','EmailAddress','Name','MessageTitle','GotContent' ])` to `filename`.csv
//ask paste file:///Users/lookang/Desktop/tagui/flows/wogaa/daily-sentiments-report-24-Jul-2022-singapore-student-learning-space-sls.html into the browser yourself
// file:///Users/lookang/Desktop/tagui/flows/wogaa/daily-sentiments-report-24-Jul-2022-singapore-student-learning-space-sls.html
click Export to CSV 
click All Services
// file created

load `filename`.csv to body1
echo `body1`
//create name of different _1 for debugging
dump  `([ 'DataTime', 'ServiceName','TXNID','PageURL', 'BrowserVersion','OSDevice','Geographic','Rating','EmailAddress','Name','MessageTitle','GotContent' ])` to `filename`_1.csv
write `body1` to `filename`_1.csv

click Ratings 4 & below
click /html/body/div/div[2]/div/div[2]/div/div[1]/div[2]/div/div/span/button
click /html/body/div/div[2]/div/div[2]/div/div[1]/div[2]/div/div[2]/div/div/a[1]
// second file created with same name
// default name of file after export is 
load `filename`.csv to body2
echo `body2`
// create blank file
dump `([ 'DataTime', 'ServiceName','TXNID','PageURL', 'BrowserVersion','OSDevice','Geographic','Rating','EmailAddress','Name','MessageTitle','GotContent' ])` to `filename`_2.csv
write `body2` to `filename`_2.csv
//live

//delete exisiting data
dump `([ 'DataTime', 'ServiceName','TXNID','PageURL', 'BrowserVersion','OSDevice','Geographic','Rating','EmailAddress','Name','MessageTitle','GotContent' ])` to `filename`.csv
//combine
//write `body1` to singapore_student_learning_space_(sls)-daily-24_07_2022.csv
write `body1` to `filename`.csv
write `body2` to `filename`.csv
load `filename`.csv to bodyfull
echo `bodyfull`



filedate = filename.substring(45, 65)
column_A = [`filename`.csv]singapore_student_learning_spac!A:A
//echo `column_A`
filelength = column_A.length




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
//declare as arrays
MessageTitlefull =[]
MessageBodyfull =[]
EmailAddressfull =[]
Namefull = []

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
console.log("EmailAddress = " +EmailAddressfull[k]);
// EmailAddress = 瑞恩@xxxxx.com
Namefull[k] = row[9]
MessageTitlefull[k] = row[10]
MessageBodyfull[k] = row[11]
// M is blank
//N is unused
//GotContent[k] = row [14]
}





js finish
//-------------------------------------------







dump `([ 'DataTime', 'ServiceName','TXNID','PageURL', 'BrowserVersion','OSDevice','Geographic','Rating','EmailAddress','Name','MessageTitle','GotContent' ])` to  `filename`_filtered.csv
start = 1
for i from start to filelength-1
    if EmailAddressfull[i] equals to "" or Namefull[i] equals to "" or MessageTitlefull[i] equals to "" or MessageBodyfull[i] equals to ""
        echo skip `i`
    else 
        write `csv_row(pendingfull[i])` to `filename`_filtered.csv
        echo `pendingfull[i]`
