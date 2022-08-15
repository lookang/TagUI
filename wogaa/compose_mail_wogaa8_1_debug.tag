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


// this file is created to handle dirty data such as üëçüëçüëçüëçüëçüëç
// found in file _2 27_07_2022 file cell J33 üëçüëçüëçüëçüëçüëç
//skip 25
// ERROR - undefined is not an object (evaluating 'cell_data.toString')
//27/7/22 20:31	Singapore Student Learning Space (SLS)	null	https://vle.learning.moe.edu.sg/mrv/assignment/attempt/5f71e4a1-6fd6-4226-a811-a61d3364332e/page/43674855	Chrome 103	Unknown ??	Singapore	2	NUHHHNUHHHHNUHHHHNUHHHHNUHHHNUHHHHHNUHHHHHNUHHHHHNUHHHHHNUHHHHNIHHHNUHHHNUHHHHNUHHHHNUHHHHNUHHHNUHHHHHNUHHHHHNUHHHHHNUHHHHHNUHHHHNIHHHNUHHHNUHHHHNUHHHHNUHHHHNUHHHNUHHHHHNUHHHHHNUHHHHHNUHHHHHNUHHHHNIHHHNUHHHNUHHHHNUHHHHNUHHHHNUHHHNUHHHHHNUHHHHHNUHHHHHNUHHH	üëçüëçüëçüëçüëçüëç	TOTOY TOTOY TOTOY TOTOY	armiedt@yahoo.com
// after data clean up run this file without the download and processing into _1 and _2

// erase file
//var fs = require('fs');
//fs.remove('/Users/lookang/Desktop/tagui/flows/wogaa/singapore_student_learning_space_(sls)-daily-24_07_2022.csv');

ask What is the date to be processed ( in DD_MM_YYYY for example 27_07_2022)
//ask What
echo `ask_result`
js temp = "singapore_student_learning_space_(sls)-daily-"+ask_result
echo temp = `temp`
// may need to edit manually
//filename = "singapore_student_learning_space_(sls)-daily-27_07_2022"
filename = temp


//assume files are there
// to load back the body.....
wait 3
load `filename`.csv to bodyfull
echo `bodyfull`
load `filename`_1.csv to body_1
echo `body_1`
load `filename`_2.csv to body_2
echo `body_2`




filedate = filename.substring(45, 65)
column_A = [`filename`.csv]singapore_student_learning_spac!A:A
//echo `column_A`
filelength = column_A.length
echo filelength = `filelength`
column_A_1 = [`filename`_1.csv]singapore_student_learning_spac!A:A
//echo `column_A`
filelength_1 = column_A_1.length
echo filelength_1 = `filelength_1`
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
echo filelength = `filelength`
for i from start to (filelength-2)
    j = i+2
    //ERROR - undefined is not an object (evaluating 'cell_data.toString')
    echo EmailAddressfull[i] = `EmailAddressfull[i]`
    echo Namefull[i] = `Namefull[i]`
    echo MessageTitlefull[i] = `MessageTitlefull[i]`
    echo MessageBodyfull[i] = `MessageBodyfull[i]`
    if (EmailAddressfull[i] equals to "") or (Namefull[i] equals to "") or (MessageTitlefull[i] equals to "") or (MessageBodyfull[i] equals to "")
        echo skip `i`, row = `j`
    else 
        write `csv_row(pendingfull[i])` to `filename`_filtered.csv
        echo `pendingfull[i]`
