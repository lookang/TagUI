// YouTube 
// GitHub  https://github.com/lookang/TagUI/blob/main/turnonlanguage/cgpublishgameoffsmart.tag
//https://tagui.readthedocs.io/en/latest/reference.html

filename = "SLS_CG _2022_05Jun"
load `filename`.csv to body
//echo `body`
column_A = [`filename`.csv]SLS_CG _2022_05Jun!A:A
//echo column A = `column_A`
filelength = column_A.length
echo filelength = `filelength`
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

//declare as arrays
Course = []
URL = []

start_from_sn = 1;

for(var k = start_from_sn; k < pending.length; k++){
//for(var k = start_from_sn; k < 3; k++){
row = pending[k];
//console.log("row = "+ row);
Course[k] = row[0] 
//console.log("Subject = " +Subject[k]);
URL[k] = row[9]
//console.log("URL = " +URL[k]);
}
js finish

//live



//visit URL
https://vle.learning.moe.edu.sg/mrv/community-gallery/admin

//assume login needed
//if present('.button.login')
wait 1
if present('//button[@type="button"]')
    click .button.login
    wait 5

    code = ""
    https://mail.google.com/mail/u/0/#inbox"
    // Click Sign in 
    wait 5
    // click the first email by notifications@sls.ufinity.com in the table
    click //*[@email="notifications@sls.ufinity.com"]/ancestor-or-self::tr
    read //div[7]/div[3]/div/div[2]/div[1]/div[2]/div/div/div/div/div[2]/div/div[1]/div/div[2]/div/table/tr/td[1]/div[2]/div[2]/div/div[3]/div/div/div/div/div/div[1]/div[2]/div[3]/div[3]/div/div[2]/h2 to code
    echo `code`
    wait 5

    // go back to SLS
    https://vle.learning.moe.edu.sg/mrv/community-gallery/admin
    type otp as `code`
    click .field-set.type-button.otp-submit button
    wait 5 

// change this 
start = 6289
for i from start to filelength-1
    if Course[i] contains "COURSE"
        echo URL[i]= `URL[i]`
        temp = URL[i].replace("https://vle.learning.moe.edu.sg/mrv/community-gallery/lesson/view/", "");
        echo temp = `temp`
        https://vle.learning.moe.edu.sg/mrv/community-gallery/admin/lesson/view/`temp`
 
        //live
        //edit button on top right
        click (//button[@type='button'])[4]
        // 3 dots
        click Kebab24
        // enter g
        click Gamification
        wait 1
        // trying to extract title to make sure it is the defaulted value of Untitled Game
        read bx--text-input to title
        echo `title`
        //Untitled Game
        //live
        if present('//input[@aria-checked="true"]')
            read (//input[@aria-checked='true']) to gameon
            echo `gameon`
            if title equals to "Untitled Game" and gameon equals to "gamification-toggle"
                // click off g
                click bx--toggle__check
                // ok
                click (//button[normalize-space()='OK'])[1]
                // save
                click Save24
                // X
                click Close24
                // tick
                click CheckmarkCircle32
                echo game turn off for  `i` for ease of checking if turn off is accurately done and resuming if flow breaks out
            
        else if present('//input[@aria-checked="false"]')
            read (//input[@aria-checked='false']) to gameoff
            echo `gameoff`
            echo `title` and do nothing and actually code is unused
        else
            echo doing nothing then to `i` because it has other title between the default Untitled Game
        
         

    else
        echo skip  ` i` because it is a lesson