# README.md for SLS Data Crawler

This repository contains scripts that automate the process of extracting data from the Student Learning Space (SLS) featured lessons. The scripts are written in TagUI, a language for digital process automation (RPA).

## About the Scripts

The scripts are designed to automate the following tasks:

1. Navigate to SLS and crawl data from featured lessons. In theory, it can crawl all the data, but there is a limit of around 6000 due to the loop not working if the number to crawl is increased.
2. If you need to run large numbers, split the loop into smaller parts. For example:
```bash
for i from 1 to 2000
inside code
for i from 2001 to 4000
inside code
for i from 4001 to 6500
inside code
```
3. Currently, you need to manually key in the number to crawl as it is not possible to run 6500, so just edit it to a small number for the month.
4. Even if it stops suddenly, the data crawled is saved as it crawls.

## Output

The output of the script is saved in `publish_list.csv`. A small sample is included to show how it looks like, with confidential info removed of course.

## Application

The script is used to patch the latest one month data into the E-Catalogue for Teacher-Contributed SLS Community Gallery Lessons ver.20210915 e_catalogue_by_SLS_data⁵. With the TagUI script, the sheet becomes latest 20210924 for example.

## YouTube Video

There is a YouTube video that provides more context about these scripts:

- [YouTube Video](^1^)

## Contributing

Contributions are welcome! Feel free to fork the repository and make changes. When you are ready to submit your changes, send a pull request.

Please note that this README is generated based on available information and may not fully represent the actual content of the repository.

Source: Conversation with Bing, 01/11/2023
(1) Google Sheets: Sign-in. https://docs.google.com/spreadsheets/u/0/.
(2) YouTube. https://www.youtube.com/?watch=.
(3) YouTube - YouTube. https://www.youtube.com/%20youtube.
(4) 【油管100w+】 Unity 入门视频_哔哩哔哩_bilibili. https://www.bilibili.com/video/BV1PF41147Rd/.
(5) Download Youtube Videos for Free - SaveFrom.net. https://en.savefrom.net/1-youtube-video-downloader-533nN/.
(6) Google Drive: Sign-in. https://drive.google.com/drive/?usp=sheets_home&ths=true.
(7) Access Sheets - Google Docs Editors Help. https://support.google.com/docs/answer/9330961?hl=en.
(8) Google Sheets API Overview | Google for Developers. https://developers.google.com/sheets/api/guides/concepts.
(9) Make Google Docs, Sheets, Slides & Forms public. https://support.google.com/docs/answer/183965?hl=en&co=GENIE.Platform%3DDesktop.
(10) undefined. https://docs.google.com/spreadsheets/d/.

read
https://www.youtube.com/watch?v=QB28qd3uNr8

to go SLS and crawl data out from featured lessons, in theory it can crawl out all the data but i believe that is a limit like 6000 due to the loop didnt work if i increase the numbertocrawl.
indeed thre is a limit to the tagui loop number no larger than 6000
if need to run large numbers, split the loop into smaller parts
for i from 1 to 2000
inside code
for i from 2001 to 4000
inside code
for i from 4001 to 6500
inside code

for example


current working
need to key in the numbertocrawl manually as it is not possible to run 6500, so just edit to small number for the month

strengths
even if stops suddenly, the data crawled is saved as it crawls.


output
publish_list.csv

a small sample is include to show how it looks like, with confidential info removed of course

application to patch latest one month data into the E-Catalogue for Teacher-Contributed SLS Community Gallery Lessons ver.20210915 e_catalogue_by_SLS_data
https://docs.google.com/spreadsheets/d/16q85oHC3Da9yxRxat3Usb85crXUQjRNP/edit#gid=1487995968
with the TagUI
the sheet becomes latest 20210924 for example.
