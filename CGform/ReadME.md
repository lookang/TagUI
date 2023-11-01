# README.md for SLS Auto Login and Data Extraction

This repository contains scripts that automate the login process to the Student Learning Space (SLS), extract the first featured data of a lesson, and populate a Google Form with the extracted data. The scripts are written in JavaScript and TagUI, a language for digital process automation (RPA).

## About the Scripts

The scripts are designed to automate the following tasks:

1. Auto login to SLS.
2. Retrieve a 2-Factor Authentication (2FA) code from an email.
3. Extract the first featured data of a lesson from SLS.
4. Populate a Google Form with the extracted data based on certain logic.

There are two versions of the scripts:

- The first version is written in JavaScript and TagUI, using methods like `split` and `trim`.
- The second version is almost purely written in TagUI, simplifying the code by using statements like `if ________ contains " "`. This version also includes fixes for parts of the code with statements like `if subject contains 'english' or subject contains 'literature'`.

## YouTube Videos

There are two YouTube videos that provide more context about these scripts:

1. [First Video](^1^)
2. [Second Video](^5^) - This video provides better scripts.

## Google Forms and Sheets

The scripts interact with the following Google Forms and Sheets:

- [Existing Manual Form](^6^)
- [Existing CG Catalogue](^11^)
- [Future CG Catalogue](^11^)

## Contributing

Contributions are welcome! Feel free to fork the repository and make changes. When you are ready to submit your changes, send a pull request.

Please note that this README is generated based on available information and may not fully represent the actual content of the repository.

Source: Conversation with Bing, 01/11/2023
(1) YouTube. https://www.youtube.com/?watch=.
(2) Matthew West - Truth Be Told (Official Music Video) - YouTube. https://www.youtube.com/watch?v=j4wYkS8Z3Io.
(3) Google Forms: Sign-in. https://docs.google.com/forms/u/0/.
(4) Google Sheets: Sign-in. https://docs.google.com/spreadsheets/u/0/.
(5) Google Sheets: Sign-in. https://docs.google.com/spreadsheets/u/0/.
(6) YouTube - YouTube. https://www.youtube.com/Youtube/watch.
(7) 【油管100w+】 Unity 入门视频_哔哩哔哩_bilibili. https://www.bilibili.com/video/BV1PF41147Rd/.
(8) Learn Division for Kids - 2nd and 3rd Grade Math Video - YouTube. https://www.youtube.com/watch?v=gjqxhtjyfC4.
(9) Google Forms: Online Form Creator | Google Workspace. https://www.google.com/forms/about/.
(10) نماذج Google: أداة لإنشاء النماذج على الإنترنت | Google Workspace. https://www.google.com.sa/intl/ar/forms/about/.
(11) Google Forms: Online Form Builder for Business | Google Workspace. https://workspace.google.com/products/forms/.
(12) How to use Google Forms - Computer - Google Docs Editors Help. https://support.google.com/docs/answer/6281888?hl=en&co=GENIE.Platform%3DDesktop.
(13) Google Sheets: Online Spreadsheet Editor | Google Workspace. https://www.google.com/sheets/about/.
(14) Make Google Docs, Sheets, Slides & Forms public. https://support.google.com/docs/answer/183965?hl=en&co=GENIE.Platform%3DDesktop.
(15) Google Sheets API Overview | Google for Developers. https://developers.google.com/sheets/api/guides/concepts.
(16) Access Sheets - Google Docs Editors Help. https://support.google.com/docs/answer/9330961?hl=en.
(17) Google Drive: Sign-in. https://drive.google.com/drive/?usp=sheets_home&ths=true.
(18) undefined. https://www.MageMath.com/.
(19) undefined. https://matthewwest.lnk.to/BrandNewID.
(20) undefined. https://docs.google.com/spreadsheets/d/.

https://www.youtube.com/watch?v=4WFc3Turr9A 
https://www.youtube.com/watch?v=O2nbJRKqcJM 2nd Video with better scripts
auto login to SLS
get 2FA from email
extract SLS first featured data of lesson
populate with logic the google form

existing manual form
https://docs.google.com/forms/d/e/1FAIpQLSeWt27t9Hys2CixHUiYF76eOWFTlxyPGSHLNTLTrLN93Nm1XQ/viewform
existing CG catalogue
https://docs.google.com/spreadsheets/d/1xSxRqqfgfqIzxBRTH4YanQmrx0seS-B3ItULQ3x0si8/edit#gid=1984583251

future CG catalogue
https://docs.google.com/spreadsheets/d/16q85oHC3Da9yxRxat3Usb85crXUQjRNP/edit#gid=767792340

versions
1. first attempt with js and tagui using split trim etc
2. almost pure tagui using if ________ contains " " which simplify the code. fixed or part of the code with if subject contains 'english' or subject contains 'literature'

