//live
start = 269
counter = 0
//live

for page = start to 300 
    //live
    counter = counter +1
    echo counter is  `counter`
    https://sg.iwant2study.org/ospsg/index.php/`page`
    //live
    wait 3
    //url = url()
    //url = https://sg.iwant2study.org/ospsg/index.php/`page`
    //echo url is `url`

    //live
    if counter equals to  1
        page_title = title()
        // after you get page_title:
        js page_title_lower = page_title.toLowerCase()
        echo page_title is `page_title`
        textAll =  text() 
        //echo textAll is `textAll`
        //echo `text()`
        wait 3
    
    if present("//*[@id='content']/div[3]/div[1]/h2")
        read //*[@id="content"]/div[3]/div[1]/h2 to text
        echo text as `text`
    
    if page_title_lower contains "404 Article not found"
        echo found 404 Article not found, going to next page 
        //break
    else if page_title_lower contains "Phet" 
        echo found Phet Article  going to next page 
        //break
    else if page_title_lower contains "geogebra" 
        echo found GeoGebra Article  going to next page 
        //break
    else if page_title_lower contains "molecularworkbench" 
        echo found MolecularWorkbench Article  going to next page 
        //break
    else if page_title_lower contains "unpublished"
        echo found unpublished Article  going to next page 
        //break
    else
        echo found a ejs or tracker page is `page`  
        //live
        https://notebooklm.google.com/?pli=1
        https://notebooklm.google.com/?pli=1&authuser=1
        //live
        click //span[contains(text(),'Create new')]

        click //span[contains(text(),'Website')]
        //live
        //click //input[@id='mat-input-0']
        click //input[@formcontrolname='newUrl']
        //page = 6
        //https://sg.iwant2study.org/ospsg/index.php/`page`

        type //input[@formcontrolname='newUrl'] as https://sg.iwant2study.org/ospsg/index.php/`page`
        wait 5
        click //span[normalize-space()='Insert']
        wait 5
        //Generate audio
        click /html[1]/body[1]/labs-tailwind-root[1]/div[1]/notebook[1]/notebook2[1]/div[1]/section[3]/div[3]/audio-overview[1]/div[1]/div[1]/div[2]/div[2]/button[1]/span[2]

        // briefing doc
        click /html[1]/body[1]/labs-tailwind-root[1]/div[1]/notebook[1]/notebook2[1]/div[1]/section[3]/note-panel[1]/div[1]/div[1]/div[2]/button[2]/span[2]
        wait 20
        //if present("//span[contains(text(),'briefing doc')]")
        //    click //span[contains(text(),'briefing')]
        //        //study guide
        
        //study note
        click /html[1]/body[1]/labs-tailwind-root[1]/div[1]/notebook[1]/notebook2[1]/div[1]/section[3]/note-panel[1]/div[1]/div[1]/div[2]/button[1]/span[2]
        wait 5
        

        // faq
        click /html[1]/body[1]/labs-tailwind-root[1]/div[1]/notebook[1]/notebook2[1]/div[1]/section[3]/note-panel[1]/div[1]/div[1]/div[3]/button[1]/mat-icon[1]
        wait 5
        // share


        
        //click //div[@class='ql-editor']
        //keyboard [ctrl]a
        //keyboard [ctrl]c
        // new tab
        //dom window.open('https://sg.iwant2study.org/ospsg/index.php/`page`')
        //dom window.open("`url`")
        
        echo `counter`
        if counter equals to 1 
            wait 2
            keyboard [ctrl]t
            wait 2
            keyboard [ctrl]l
            wait 2
            //keyboard `url`[enter]
            keyboard https://sg.iwant2study.org/ospsg/index.php/`page`[enter]
            //live
            wait 3
            popup ospsg
                if present("//button[normalize-space()='Log in']")
                    click //button[normalize-space()='Log in']
                //keyboard [ctrl]t
                wait 2
                keyboard [ctrl]l
                wait 2
                keyboard https://sg.iwant2study.org/ospsg/index.php/`page`[enter]
                if present("//button[@aria-label='User tools']")
                    click //button[@aria-label='User tools']
                    click //a[@title='Edit article']
                //live
                //dom window.close()
        else
            //do nothing
        wait 10

    echo page is `page` 
    live
//endif
