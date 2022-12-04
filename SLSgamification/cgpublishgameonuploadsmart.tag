// YouTube 
// GitHub  https://github.com/lookang/TagUI/blob/main/turnonlanguage/cgpublishgameoffsmart.tag
//https://tagui.readthedocs.io/en/latest/reference.html

filename = "SLS_CG _2022_07Jul"
load `filename`.csv to body
//echo `body`
column_A = [`filename`.csv]SLS_CG _2022_07Jul!A:A
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
//live
//assume login needed
//if present('.button.login')
wait 1
// not distinguishing enough button, must use login-button
if present('//button[@id="login-button"]')
    //click .button.login
    click //button[@id='login-button']
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
start = 7059
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
        echo to turn to off position for flow to run to turn on off courses
        //live
        
        if present('//input[@aria-checked="false"]')
            read (//input[@aria-checked='false']) to gameoff
            echo `gameoff`


            click //button[@aria-label='Header Menu']
            // A - L
            
            read //*[@id="lesson-navigation"]/div/ul/li/a/span/div/div[2] to pagination
            // need to remove parseInt()
            js total = pagination.split("-")[1].trim();
            echo There are `total` number of sections
            if total equals to "A" 
                total = 1
            else if total equals to "B" 
                total = 2
            else if total equals to "C" 
                total = 3
            else if total equals to "D" 
                total = 4
            else if total equals to "E" 
                total = 5
            else if total equals to "F" 
                total = 6
            else if total equals to "G" 
                total = 7
            else if total equals to "H" 
                total = 8
            else if total equals to "I" 
                total = 9
            else if total equals to "J" 
                total = 10
            else if total equals to "K" 
                total = 11
            else if total equals to "L" 
                total = 12
            else if total equals to "M" 
                total = 13
            else if total equals to "N" 
                total = 14
            else if total equals to "O" 
                total = 15
            else if total equals to "P" 
                total = 16
            else if total equals to "Q" 
                total = 17
            else if total equals to "R" 
                total = 18
            else if total equals to "S" 
                total = 19
            else if total equals to "T" 
                total = 20
            // need to do for 20 
            echo `total`

            // go back to main page
            click (//button[@aria-label='Header Menu'])[1]
            //live
            if gameoff equals to "gamification-toggle"
                // click off/on g
                click bx--toggle__check
                // ok
                if present('(//button[normalize-space()="OK"])[1]')
                    click (//button[normalize-space()='OK'])[1]
                
                //title
                type bx--text-input as [clear] Game
                //Description btw clear doesnt work on mce
                //type mce-content-body mce-edit-focus as [clear]First Game
                //live
                click (//div[@class='paragraph'])[10]
                type (//div[@class='paragraph'])[10] as [clear]SLS Third Game template added 
                // got to use the add extra # and the id
                // upload #uid-648cfdca-7fff-4f33-818a-05950f071a45 as game1/1.jpeg         
                if present('//img[@alt="gamification_featured_image"]')
                    echo skip 1
                else
                    // assuming first upload Game Story
                    upload [type~="file"] as game3/13 helps others.png

                if present('//img[@alt="gamification-achievement-background"]')
                    echo skip 2
                else
                    //assuming 2nd 
                    upload [type~="file"] as game3/07 make good progress.png

                // Game Story tab
                for j from 1 to total
                    echo j is `j`
                    click //a[@id='story-link']
                    // ADD GAME STORY
                    click //button[normalize-space()='ADD GAME STORY']
                    //Title
                    // bx--text-input as [clear]Story `j`
                    //type bx--text-input__field-wrapper [clear]Story `j`
                    type /html[1]/body[1]/div[3]/div[2]/div[1]/div[2]/div[1]/div[3]/form[1]/dl[1]/dd[1]/div[1]/div[1]/input[1] as [clear]Story `j`
                    // Description, not working well in mce editor
                    click /html/body/div[3]/div[2]/div/div[2]/div/div[3]/form/dl[2]/dd/div
                    // not working well if there is some words there
                    //type //div[@class='mce-content-body mce-edit-focus'] as [clear]Story `j` Description
                    if j less than total/3
                        upload [type~="file"] as game3/B1 novice.png
                    else if j less than 2*total/3
                        upload [type~="file"] as game3/A2 apprentice.png
                    else if j less than 3*total/3
                        upload [type~="file"] as game3/B3 expert.png
                    //CREATE game story item
                    click cv-button bx--btn bx--btn--primary bx--btn--field

                    // in sub page
                    // ADD CONDITIONS
                    // iterate [1] to [i]
                    //live
                    //click (//a[@class='cv-link link-button game-condition add bx--link'])[`j`]
                    echo live
                    wait 5
                    live
                    //click //span[normalize-space()='ADD CONDITIONS']
                    //first +lock ADD CONDIITONS
                    // check present to avoid doing the clicks if it is already populated with conditions and will skip-save
                    //if present('//*[@id="story"]/div/div[2]/div/div[`j`]/div[2]/form/dl[2]/dd/div[1]/a')
                    click //*[@id="story"]/div/div[2]/div/div[`j`]/div[2]/form/dl[2]/dd/div[1]/a
                    // second
                    //click //*[@id="story"]/div/div[2]/div/div[2]/div[2]/form/dl[2]/dd/div[1]/a
                    // +ADD CONDITION+
                    //live
                    echo to be continue 
                    // didnt work so use relative xpath from inspect
                    //click //span[normalize-space()='ADD CONDITION']
                    // first
                    if j equals to 1
                        click //*[@id="story"]/div/div[2]/div/div/div[2]/form/dl[2]/dd/div[1]/a
                    //second
                    if j greater than 1
                        click //*[@id="story"]/div/div[2]/div/div[`j`]/div[2]/form/dl[2]/dd/div[1]/a
                    // fourth
                    //click //*[@id="story"]/div/div[2]/div/div[4]/div[2]/form/dl[2]/dd/div[2]/div/div/div[2]/div/form/dl[2]/dd/div/button/span
                    //click //span[normalize-space()='Section Start']
                    //click //span[@class='bx--overflow-menu-options__option-content'][normalize-space()='Section Start']
                    temp = 63+2*j
                    click /html/body/div[`temp`]/ul/li[1]/button/span
                    // second
                    //click /html/body/div[67]/ul/li[1]/button/span
                    //click /html/body/div[69]/ul/li[1]/button/span
                    //click 
                    // A is 2, B is 3, C is 4 and etc 
                    wait 1
                    //click Choose an option
                    //first
                    click /html/body/div[3]/div/div/div[2]/div/div[4]/div[2]/div[3]/div/div[2]/div/div[`j`]/div[2]/form/dl[2]/dd/div[2]/div/div/div[2]/div/form/dl[1]/dd/ul/li/div/div/div/button/span
                    //second
                    //click /html/body/div[3]/div/div/div[2]/div/div[4]/div[2]/div[3]/div/div[2]/div/div[2]/div[2]/form/dl[2]/dd/div[2]/div/div/div[2]/div/form/dl[1]/dd/ul/li/div/div/div/button/span
                    //third
                    //click /html/body/div[3]/div/div/div[2]/div/div[4]/div[2]/div[3]/div/div[2]/div/div[3]/div[2]/form/dl[2]/dd/div[2]/div/div/div[2]/div/form/dl[1]/dd/ul/li/div/div/div/button/span
                    // iterate [2] to [i+1]
                    k = j+1
                    click (//span[@class='page-label'])[`k`]
                    // save
                    //click (//span[@data-text='Save'])
                    //firdst
                    click //*[@id="story"]/div/div[2]/div/div[`j`]/div[2]/form/dl[2]/dd/div[2]/div/div/div[3]/div/button/span
                    //second
                    //click //*[@id="story"]/div/div[2]/div/div[2]/div[2]/form/dl[2]/dd/div[2]/div/div/div[3]/div/button/span
                    //third
                    //click //*[@id="story"]/div/div[2]/div/div[3]/div[2]/form/dl[2]/dd/div[2]/div/div/div[3]/div/button/span
                



                
                // save
                click Save24
                
                
                
                
                //live 


                // save
                click Save24
                // X
                click Close24
                // tick
                click CheckmarkCircle32
                echo game turn off for  `i` for ease of checking if turn off is accurately done and resuming if flow breaks out
            
        else if present('//input[@aria-checked="true"]')
            read (//input[@aria-checked='true']) to gameon
            echo `gameon`
            echo `title` and do nothing and actually code is unused
        else
            echo doing nothing then to `i` because it has other title between the default Untitled Game
        
         

    else
        echo skip  ` i` because it is a lesson