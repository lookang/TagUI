// This script is designed to be run on the command line.
// type
// tagui lfacrawlwebsite1.tag -t
// FINISH - automation finished - 92.2s


// The data in the EXCEL file


// Please note the following limitations:

// Navigate to the page
https://dev2.literatu.com/api-test-moe.html

// write header of csv
dump Number, Sentence, issueText, errant Codes to dataLFAwebsite1.csv

// read EXCEL file
fileName = "C:/tagui/flows/LanguageFeedbackAssistantWebsite/database"
// fileName = "database"
sheetName = "ForRPA"
cellName = "A2:B3001"
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
        read /html/body/div/form/div/div[2]/div[2]/div[1]/div[1]/table/tbody/tr[2]/td[1]/a/span to issueTextb
        echo `issueTextb`
        read /html/body/div/form/div/div[2]/div[2]/div[1]/div[1]/table/tbody/tr[2]/td[2] to errorCodeb
        echo `errorCodeb`
        write `csv_row([number,sentence,issueTextb,errorCodeb])` to dataLFAwebsite1.csv
        //writeAnything = true

    if present('/html/body/div/form/div/div[2]/div[2]/div[1]/div[1]/table/tbody/tr[3]/td[1]/a/span')
        read /html/body/div/form/div/div[2]/div[2]/div[1]/div[1]/table/tbody/tr[3]/td[1]/a/span to issueTextc
        echo `issueTextc`
        read /html/body/div/form/div/div[2]/div[2]/div[1]/div[1]/table/tbody/tr[3]/td[2] to errorCodec
        echo `errorCodec`
        write `csv_row([number,sentence,issueTextc,errorCodec])` to dataLFAwebsite1.csv
        //writeAnything = true

    if present('/html/body/div/form/div/div[2]/div[2]/div[1]/div[1]/table/tbody/tr[4]/td[1]/a/span')
        read /html/body/div/form/div/div[2]/div[2]/div[1]/div[1]/table/tbody/tr[4]/td[1]/a/span to issueTextd
        echo `issueTextd`
        read /html/body/div/form/div/div[2]/div[2]/div[1]/div[1]/table/tbody/tr[4]/td[2] to errorCoded
        echo `errorCoded`
        write `csv_row([number,sentence,issueTextd,errorCoded])` to dataLFAwebsite1.csv
        //writeAnything = true

    if present('/html/body/div/form/div/div[2]/div[2]/div[1]/div[1]/table/tbody/tr[5]/td[1]/a/span')
        read /html/body/div/form/div/div[2]/div[2]/div[1]/div[1]/table/tbody/tr[5]/td[1]/a/span to issueTexte
        echo `issueTexte`
        read /html/body/div/form/div/div[2]/div[2]/div[1]/div[1]/table/tbody/tr[5]/td[2] to errorCodee
        echo `errorCodee`
        write `csv_row([number,sentence,issueTexte,errorCodee])` to dataLFAwebsite1.csv
        //writeAnything = true

    if present('/html/body/div/form/div/div[2]/div[2]/div[1]/div[1]/table/tbody/tr[6]/td[1]/a/span')
        read /html/body/div/form/div/div[2]/div[2]/div[1]/div[1]/table/tbody/tr[6]/td[1]/a/span to issueTextf
        echo `issueTextf`
        read /html/body/div/form/div/div[2]/div[2]/div[1]/div[1]/table/tbody/tr[6]/td[2] to errorCodef
        echo `errorCodef`
        write `csv_row([number,sentence,issueTextf,errorCodef])` to dataLFAwebsite1.csv
        //writeAnything = true

    if present('/html/body/div/form/div/div[2]/div[2]/div[1]/div[1]/table/tbody/tr[7]/td[1]/a/span')
        read /html/body/div/form/div/div[2]/div[2]/div[1]/div[1]/table/tbody/tr[7]/td[1]/a/span to issueTextg
        echo `issueTextg`
        read /html/body/div/form/div/div[2]/div[2]/div[1]/div[1]/table/tbody/tr[7]/td[2] to errorCodeg
        echo `errorCodeg`
        write `csv_row([number,sentence,issueTextg,errorCodeg])` to dataLFAwebsite1.csv
        //writeAnything = true

    if present('/html/body/div/form/div/div[2]/div[2]/div[1]/div[1]/table/tbody/tr[8]/td[1]/a/span')
        read /html/body/div/form/div/div[2]/div[2]/div[1]/div[1]/table/tbody/tr[8]/td[1]/a/span to issueTexth
        echo `issueTexth`
        read /html/body/div/form/div/div[2]/div[2]/div[1]/div[1]/table/tbody/tr[8]/td[2] to errorCodeh
        echo `errorCodeh`
        write `csv_row([number,sentence,issueTexth,errorCodeh])` to dataLFAwebsite1.csv
        //writeAnything = true

    if present('/html/body/div/form/div/div[2]/div[2]/div[1]/div[1]/table/tbody/tr[9]/td[1]/a/span')
        read /html/body/div/form/div/div[2]/div[2]/div[1]/div[1]/table/tbody/tr[9]/td[1]/a/span to issueTexti
        echo `issueTexti`
        read /html/body/div/form/div/div[2]/div[2]/div[1]/div[1]/table/tbody/tr[9]/td[2] to errorCodei
        echo `errorCodei`
        write `csv_row([number,sentence,issueTexti,errorCodei])` to dataLFAwebsite1.csv
        //writeAnything = true

    if present('/html/body/div/form/div/div[2]/div[2]/div[1]/div[1]/table/tbody/tr[10]/td[1]/a/span')
        read /html/body/div/form/div/div[2]/div[2]/div[1]/div[1]/table/tbody/tr[10]/td[1]/a/span to issueTextj
        echo `issueTextj`
        read /html/body/div/form/div/div[2]/div[2]/div[1]/div[1]/table/tbody/tr[10]/td[2] to errorCodej
        echo `errorCodej`
        write `csv_row([number,sentence,issueTextj,errorCodej])` to dataLFAwebsite1.csv
        //writeAnything = true

    if present('/html/body/div/form/div/div[2]/div[2]/div[1]/div[1]/table/tbody/tr[11]/td[1]/a/span')
        read /html/body/div/form/div/div[2]/div[2]/div[1]/div[1]/table/tbody/tr[11]/td[1]/a/span to issueTextk
        echo `issueTextk`
        read /html/body/div/form/div/div[2]/div[2]/div[1]/div[1]/table/tbody/tr[11]/td[2] to errorCodek
        echo `errorCodek`
        write `csv_row([number,sentence,issueTextk,errorCodek])` to dataLFAwebsite1.csv
        //writeAnything = true

    if present('/html/body/div/form/div/div[2]/div[2]/div[1]/div[1]/table/tbody/tr[12]/td[1]/a/span')
        read /html/body/div/form/div/div[2]/div[2]/div[1]/div[1]/table/tbody/tr[12]/td[1]/a/span to issueTextl
        echo `issueTextl`
        read /html/body/div/form/div/div[2]/div[2]/div[1]/div[1]/table/tbody/tr[12]/td[2] to errorCodel
        echo `errorCodel`
        write `csv_row([number,sentence,issueTextl,errorCodel])` to dataLFAwebsite1.csv
        //writeAnything = true

    // no error table
    if writeAnything equals to false
        write `csv_row([number,sentence])` to dataLFAwebsite1.csv
    
    click //button[contains(text(),'📝 Go back to edit mode')]
    //live

  
  


