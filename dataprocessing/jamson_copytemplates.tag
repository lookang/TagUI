// using phantomjs for file directory listing
//https://phantomjs.org/api/fs/method/is-file.html


// list of files in the "/csvtoxlsxout/" folder as the flow file
list = get_files('./csvtoxlsxout/')
echo `list`
// expected output is 

echo this creates all the 300 + templates xlsx for the copy and pasting of data from website

for n from 0 to list.length-1
    
    echo list[n] = `list[n]`
    js list[n] = list[n].substring(0, list[n].length - 5); 
    echo list[n] after  = `list[n]`
    
    //https://phantomjs.org/api/fs/method/copy.html
    fs = require('fs');
    fs.copy("/Users/lookang/Desktop/tagui/flows/jamson/output/ILP Main File_amended.xlsx", "/Users/lookang/Desktop/tagui/flows/jamson/output/ILP Main File_amended"+list[n]+".xlsx");

echo close excel and remember to save the files





