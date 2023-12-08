# SLS Login and Data Extraction

This repository contains a script for logging into the Student Learning Space (SLS) or MIMS, navigating to a specific assignment page, and extracting data to a CSV file.

## Description

The script logs into the SLS or MIMS based on the user's choice. It then navigates to a specific assignment page and extracts data from each component on the page. The extracted data includes the paragraph, incorrect and correct text, and keyword tag. This data is then written to a CSV file.

## Usage

1. Set the `ask_result` variable to `1` for SLS login or `2` for MIMS login.
2. Run the script. It will automatically navigate to the SLS login page and log in based on your choice.
3. The script will then navigate to a specific assignment page.
4. It will count the number of components on the page and loop through each one.
5. For each component, it will extract the paragraph, incorrect and correct text, and keyword tag.
6. The extracted data is then written to a CSV file named `dataLFA.csv`.

## Code

Here is the TagUI code:

```javascript
// Navigate to the SLS login page
https://vle.learning.moe.edu.sg/login

// Ask 1 for SLS 2 for MIMS login
ask_result = 2
echo `ask_result`

// Click the appropriate login button based on ask_result
if ask_result equals to 1
    click_if_present('//button[normalize-space()="Login With SLS"]')
    click_if_present("//button[normalize-space()='Login']")
else if ask_result equals to 2
    click_if_present("//button[normalize-space()='Login With MIMS']")
    wait 3
    click (//span[@id='loginButton2'])[1]

// Navigate to the assignment page
wait 3
https://vle.learning.moe.edu.sg/assignment/view/ee899407-69ab-47ba-8c63-599c20e95840/page/70800629?user=621282&quizPage=1

live
wait 5

// Get the count of components
countOfComponent = count ("//body/div/div/main[@tag='component']/div/div/div/div/div/section[2]/div[1]/div[1]/div[1]/div")
echo `countOfComponent`

// Create a blank CSV file with header
dump Paragraph,Incorrect,Correct,KeywordTag to dataLFA.csv

// Loop through each component
for n from 1 to countOfComponent
    click //body/div/div/main[@tag='component']/div/div/div/div/div/section[2]/div[1]/div[1]/div[1]/div[`n`]
    countofIncorrectCorrect = count ("(//div[@class='output-text mce-content rich-text-content loaded primary-truncation'])")
    echo `countofIncorrectCorrect`
    
    // Read the incorrect and correct text
    read (//div[@class='output-text mce-content rich-text-content loaded primary-truncation'])[2*n] to Incorrect
    echo `Incorrect`
    read (//div[@class='output-text mce-content rich-text-content loaded primary-truncation'])[2*n + 1] to Correct
    echo `Correct`
    
    // Read the paragraph and keyword tag
    read //div[@class='output-text mce-content rich-text-content loaded has-overflow-menu-button secondary-truncation']//div[@class='paragraph'] to Paragraph
    echo `Paragraph`
    read (//div[@class='keywords'])[n + 1] to KeywordTag
    echo `KeywordTag`
    
    // Write the data to the CSV file
    write `csv_row([Paragraph,Incorrect,Correct,KeywordTag])` to dataLFA.csv
```
