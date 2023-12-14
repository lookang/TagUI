// This script is designed to be run on the command line.
// type
// tagui lfacrawlwebsite1.tag -t
// FINISH - automation finished - 92.2s


// The data in the EXCEL file


// Please note the following limitations:

// Navigate to the page
https://dev2.literatu.com/api-test-moe.html

// write header of csv and start new file
dump Number, Sentence, issueText, errant Codes to dataLFAwebsite1.csv

// read EXCEL file
fileName = "/Users/lookang/Desktop/tagui/flows/LanguageFeedbackAssistantWebsite/database"
// fileName = "database"
sheetName = "ForRPA"
cellName = "A3:B22"
data_array = [`fileName`.xlsx]`sheetName`!`cellName`
// to work on data in data_array cell by cell
for row from 0 to data_array.length-1
    for col from 0 to data_array[row].length-1
        echo row = `row` , col = `col` , data_array = `data_array[row][col]`

// loop
start = 0
for n from start to data_array.length-1
    writeAnything = false
    type //*[@id="userText"] as [clear]`data_array[n][1]`
    echo n = `n`
    number = n +1
    echo `data_array[n][1]`
    //live
    //click //select[@class='form-control mr-2 ng-valid ng-not-empty ng-valid-required ng-dirty ng-valid-parse ng-touched']
    //click //option[@value='string:moe_check_api_prd']

    // trigger results
    click //button[@type='submit']
    //live
    wait 3
    read //*[@id="the-preview"] to sentence
    if present('/html/body/div/form/div/div[2]/div[2]/div[1]/div[1]/table/tbody/tr/td[1]/a/span')
        read /html/body/div/form/div/div[2]/div[2]/div[1]/div[1]/table/tbody/tr/td[1]/a/span to issueText
        echo `issueText`
        read /html/body/div/form/div/div[2]/div[2]/div[1]/div[1]/table/tbody/tr/td[2] to errorCode
        echo `errorCode`
        write `csv_row([number,sentence,issueText,errorCode])` to dataLFAwebsite1.csv
        writeAnything = true
        // sometimes the data is in 2 lines
        // example
        // that	PREP
        // the	DET
    if present('/html/body/div/form/div/div[2]/div[2]/div[1]/div[1]/table/tbody/tr[2]/td[1]/a/span')
        //read /html/body/div/form/div/div[2]/div[2]/div[1]/div[1]/table/tbody/tr/td[1]/a/span to issueText
        read /html/body/div/form/div/div[2]/div[2]/div[1]/div[1]/table/tbody/tr[2]/td[1]/a/span to issueTextb
        echo `issueTextb`
        read /html/body/div/form/div/div[2]/div[2]/div[1]/div[1]/table/tbody/tr/td[2] to errorCode
        read /html/body/div/form/div/div[2]/div[2]/div[1]/div[1]/table/tbody/tr[2]/td[2] to errorCodeb
        echo `errorCodeb`
        write `csv_row([number,sentence,issueTextb,errorCodeb])` to dataLFAwebsite1.csv
        //writeAnything = true

        // second error table, there is an assumption that error is not more than 2
    if present('/html/body/div/form/div/div[2]/div[2]/div[1]/div[2]/table/tbody/tr/td[1]/a/span')
        read /html/body/div/form/div/div[2]/div[2]/div[1]/div[2]/table/tbody/tr/td[1]/a/span to issueText2
        read /html/body/div/form/div/div[2]/div[2]/div[1]/div[2]/table/tbody/tr/td[2] to errorCode2
        write `csv_row([number,sentence,issueText2,errorCode2])` to dataLFAwebsite1.csv
        //writeAnything = true
  
  
    // no error table
    if writeAnything equals to false
        blank = " "
        write `csv_row([number,sentence,blank,blank])` to dataLFAwebsite1.csv
    
    click //button[contains(text(),'📝 Go back to edit mode')]
    //live

  
  


