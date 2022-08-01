//live
https://mail.google.com/mail/u/1/#inbox
https://search.google.com/u/1/search-console/index/drilldown?resource_id=https://docs.learning.moe.edu.sg/&item_key=CAMYHCAE&utm_source=wnc_10030322&utm_medium=gamma&utm_campaign=wnc_10030322&utm_content=msg_100058679&hl=en
//live
// reach excluded page
https://search.google.com/u/1/search-console/index?resource_id=https%3A%2F%2Fdocs.learning.moe.edu.sg%2F&hl=en
// excluded 213
click //div[@title='Excluded']

click //span[@title='Discovered - currently not indexed']
click //span[@title='https://docs.learning.moe.edu.sg/sls/students/user-guide/vle/student/Announcements/ReadAnnouncements.html']//div[@class='OOHai']

//live
//click //span[@data-url='https://docs.learning.moe.edu.sg/sls/students/user-guide/vle/student/StarredResources/StarResource.html']//div[@class='QEGVme'][normalize-space()='inspect URL']

// to edit manually
start = 0
echo start `start`
end = 9
for j from 9 to 9
    
    https://search.google.com/u/1/search-console/index/drilldown?resource_id=https%3A%2F%2Fdocs.learning.moe.edu.sg%2F&item_key=CAMYFiAC&hl=en
    click //*[@data-rowid='`j`']
    //click /html/body/div[7]/c-wiz/c-wiz/div/div[2]/span/div/div[2]/span/div[2]/div/div/c-wiz[2]/div/div/div[1]/div[2]/table/tbody/tr[6]/td[1]/span/span/div
    //click /html/body/div[7]/c-wiz/c-wiz/div/div[2]/span/div/div[2]/span/div[2]/div/div/c-wiz[2]/div/div/div[1]/div[2]/table/tbody/tr[`i`]/td[1]/span/span/div
    //click //*[@id="yDmH0d"]/c-wiz[2]/c-wiz/div/div[2]/span/div/div[2]/span/div[2]/div/div/c-wiz[2]/div/div/div[1]/div[2]/table/tbody/tr[4]/td[1]/span/span/div
    //click //*[@id="yDmH0d"]/c-wiz[2]/c-wiz/div/div[2]/span/div/div[2]/span/div[2]/div/div/c-wiz[2]/div/div/div[1]/div[2]/table/tbody/tr[6]/td[1]/span/span/div

    live
    click //div[normalize-space()='inspect URL']
    click //span[normalize-space()='Request indexing']
    wait 60
    if present('Got it')
        click Got it
    else 
        wait 60
        if present('Got it')
            click Got it