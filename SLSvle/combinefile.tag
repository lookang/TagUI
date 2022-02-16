
load page1.csv to temp
//echo `temp`
// dump for first line that starts a new file
dump `temp` to result.csv
//wait 5
for i from 2 to 8 
    load page`i`.csv to temp
    //echo `temp`
    //write for adding on to the same file
    write `temp` to result.csv
    //wait 5
    
//load page1.csv to page1
//dump `page1` to result.csv
//load page2.csv to page2
//write `page2` to result.csv
//load page3.csv to page3
//write `page3` to result.csv
//load page4.csv to page4
//write `page4` to result.csv
//load page5.csv to page5
//write `page5` to result.csv
//load page6.csv to page6
//write `page6` to result.csv



//assume ok
//click Submit
// confirm look 
//wait 5000