https://vle.learning.moe.edu.sg/login
wait 5

// Perform login
if present("//button[normalize-space()='Login With SLS']")
    click //button[normalize-space()='Login With SLS']
    click //button[normalize-space()='Login']

wait 3
//https://vle.learning.moe.edu.sg/manage-resource?resource=LESSON&location=MOE&ownerGroups=1126,1121,1174,1163&status=ALL&subjects=611
https://vle.learning.moe.edu.sg/manage-resource?resource=LESSON&location=MOE&ownerGroups=1126,1121,1174,1163&status=DRAFT,UNPUBLISHED&subjects=611
wait 3
// Navigate and process modules from index 15 to 20
//live
start = 1
n = start
end = 20
for n from start to end
    echo n is `n` 
    //click (//a[@class='cv-link bx--link'][normalize-space()='Open'])[`n`]
    //click (//a[@tag='component'][normalize-space()='Open'])[`n`]

    // into module from Manage Modules page
    wait 3
    click //*[@id="main-content"]/div/div/section/div/div[2]/div[2]/div/div[1]/table/tbody/tr[`n`]/td[1]/div/div/a
    
    //click (//a[@class='cv-link bx--link'][normalize-space()='Open'])[1]
    
    popup cover
    {
        // get knowledge base printout text
        wait 3
        click Kebab24
        wait 3
        click View as Print-Friendly Worksheet
        //live
        dom window.close()
    }

    popup printview
    {
        click (500,500)
        wait 6
        //os = system('uname')
        os = require('system').os.name
        if os == 'MacOS' 
        {
            echo 'MacOS'
            keyboard [cmd]a
            keyboard [cmd]c
        } 
        else if os == 'Windows' 
        {
            echo 'Windows'
            keyboard [ctrl]a
            keyboard [ctrl]c
        }
        
        //live
        dom window.close()
    }

    // into module from Manage Modules page
    wait 3
    click //*[@id="main-content"]/div/div/section/div/div[2]/div[2]/div/div[1]/table/tbody/tr[`n`]/td[1]/div/div/a
    popup cover 
    { 
        
        click Pen32

        numberOfPages = count ("(//*[name()='svg'][@name='Page32'])")
        echo numberOfPages is `numberOfPages`
        click (//*[name()='svg'][@name='Page32'])[`numberOfPages`]

        click Plus24
        wait 2
        click Plus24

        //live
        echo check quiz 
        click //p[normalize-space()='Quiz']
        wait 2

        //click //div[@class='bx--text-input__field-wrapper']
        //type //div[@class='bx--text-input__field-wrapper']//input as [clear]Quiz

        

        click (//*[name()='svg'][@name='ACPGenerate24'])[2]
        wait 3
        type bx--text-input as [clear]Quiz
        wait 1
        type bx--text-area as 5 MCQ with 4 options based on knowledge with understanding and on application of information and 2 short answers based on real life application to inspire joy of learning

        //live
        if present("Add Knowledge Base")
            click Add Knowledge Base
            wait 3
            click (700,700)
            wait 3
            //os = system('uname')
            os = require('system').os.name
            if os == 'MacOS' 
            {
                echo 'MacOS'
                keyboard [cmd]v
                
            } 
            else if os == 'Windows' 
            {
                echo 'Windows'
                keyboard [ctrl]v
                
            }
            
            //live
        
            click //span[normalize-space()='Add']
        //live

            click Kebab24
        





        if present("ACPGenerate32")
            click ACPGenerate32
            wait 60
            click fetch-data-button button tip-top tip-end btn-add
        wait 3
        click CheckmarkCircle32

        // add Learing progress inclusion
        click Pen32
        // second setting
        click (//*[name()='svg'][@name='Settings24'])[2]
        click //span[normalize-space()='Apply to all questions']
        click //span[normalize-space()='Include in Learning Progress']
        click //button[normalize-space()='Ok']
        click Close24
        click CheckmarkCircle32

        live

        wait 3
        click Approve32
        click OK
        // need to wait for approval
        wait 10
        dom window.close()



    }
    

        
