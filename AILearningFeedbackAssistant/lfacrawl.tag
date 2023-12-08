// This script is designed to be run on the command line.
// type
// tagui lfacrawl.tag


// The data in the CSV file should look something like this:


// Please note the following limitations:

// Navigate to the SLS login page
https://vle.learning.moe.edu.sg/login
//ask_result = 1

//ask 1 for SLS 2 for MIMS login
ask_result = 2
echo `ask_result`
if ask_result equals to 1
    // Click the "Login With SLS" button if present
    if present('//button[normalize-space()="Login With SLS"]')
        click //button[normalize-space()='Login With SLS']
    // Click the "Login" button if present
    if present("//button[normalize-space()='Login']")
        click //button[normalize-space()='Login']
else if ask_result equals to 2
    // Click the "Login With MIMS" button if present
    if present("//button[normalize-space()='Login With MIMS']")
        click //button[normalize-space()='Login With MIMS']
        wait 3
        click (//span[@id='loginButton2'])[1]

// csv data not clean so need to do substring manipulation
wait 3
// Navigate to the assignment page
https://vle.learning.moe.edu.sg/assignment/view/ee899407-69ab-47ba-8c63-599c20e95840/page/70800629?user=621282&quizPage=1

//live
wait 5
// Get the count of components
countOfComponent = count ("//body/div/div/main[@tag='component']/div/div/div/div/div/section[2]/div[1]/div[1]/div[1]/div")
echo `countOfComponent`
// creates blank CSV file with header
dump Paragraph,Incorrect,Correct,KeywordTag to dataLFA.csv
// Loop through each component
for n from 1 to countOfComponent
    click //body/div/div/main[@tag='component']/div/div/div/div/div/section[2]/div[1]/div[1]/div[1]/div[`n`]
    countofIncorrectCorrect = count ("(//div[@class='output-text mce-content rich-text-content loaded primary-truncation'])")
    echo `countofIncorrectCorrect`
    //wait 3
    n2 = 2*n
    // Read the incorrect and correct text
    read (//div[@class='output-text mce-content rich-text-content loaded primary-truncation'])[`n2`] to Incorrect
    echo `Incorrect`
    //wait 3
    n2Plus1 = 2*n + 1
    read (//div[@class='output-text mce-content rich-text-content loaded primary-truncation'])[`n2Plus1`] to Correct
    echo `Correct`
    //wait 3
    // Read the paragraph and keyword tag
    read //div[@class='output-text mce-content rich-text-content loaded has-overflow-menu-button secondary-truncation']//div[@class='paragraph'] to Paragraph
    echo `Paragraph`
    //wait 3
    nPlus1 = n + 1
    read (//div[@class='keywords'])[`nPlus1`] to KeywordTag
    echo `KeywordTag`
    // Write the data to the CSV file
    write `csv_row([Paragraph,Incorrect,Correct,KeywordTag])` to dataLFA.csv



