
//pdftext = [/Users/lookang/Desktop/tagui/flows/addSyllabus/9744_y22_sy.pdf]
//echo `pdftext`
//dump [`pdftext`] to text.csv


// Navigate to the SLS login page
https://vle.learning.moe.edu.sg/login
wait 3

//live

// ask 1 for SLS 2 for MIMS login
ask_result = 1
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

//else 
//do ntg to skip live
//	echo "do ntg"
//live
//crawl syllabus content map assume already know URL
//https://vle.learning.moe.edu.sg/contentmap/view/90366631-d65f-4ef4-a486-120a7cdd088f?tab=learning-outcomes

https://vle.learning.moe.edu.sg/manage-resource?resource=CONTENTMAP

wait 2
// getting total_number of rows
if present('//div[@class="v-data-footer__pagination"]')
    read //div[@class="v-data-footer__pagination"] to pagination
    js total = parseInt(pagination.split("of")[1].trim());
    echo There are `total` number of lessons.


wait 2
// change tableCnt when need
tableCnt = 1

rowCnt = 1


for i from 1 to (total-tableCnt*20)
    for m from 1 to tableCnt
        click //button[@aria-label="Next page"]
    link = ""
    //js k = 7 + i%20
    //echo k = `k`
    // click OPEN LINK
    //click (//a[@class='cv-link bx--link'])[`k`]
    click (//a[contains(text(),'Open')])[`i`]
    popup contentmap/view/
        {
        wait 1 
        js link = url()
        // read the title
        //read output-text to title
        //echo `title`
        echo link = `link`
        dom window.close()
        }
    
    //
    js temp = link
    echo temp =`temp`
    js temp2 = temp.substring(8)
    echo temp2 = `temp2`
    https://`temp2`


    //live
    click //a[@id='learning-outcomes-link']
    wait 1
    read //div[@class='title-wrapper']//h4[@class='title'] to title

    //read //*[@id="learning-outcomes"]/div/section[2] to abc
    endNodeText = count ("(//div[@class='node-text'])")
    endTreeAnchor = count ("(//span[@class='tree-anchor'])")
    echo endTreeAnchor = `endTreeAnchor`
    //live
    for j from 1 to endTreeAnchor
        //if present ('(//div[@class="node-text"])[`j`]')
        if present ('(//span[@class="tree-anchor"])')
            read (//span[@class='tree-anchor'])[`j`] to text
            echo `j` is `text`
            write `csv_row([j, text ])` to /Users/lookang/Desktop/tagui/flows/addSyllabus/folder2/`title`.csv
    
    //return to starting page
    https://vle.learning.moe.edu.sg/manage-resource?resource=CONTENTMAP
    js rowCnt++;
    if (rowCnt == 21)
        {
        //click //button[@aria-label="Next page"]
        js tableCnt++; // maybe TagUI code has no ++ so use js
        echo tableCnt = `tableCnt`
        rowCnt = 1
        wait 2
        }
//live


