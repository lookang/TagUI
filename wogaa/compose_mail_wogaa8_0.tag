// Open gmail (assumes that user has already logged in previously) 

https://mail.google.com/mail/u/0/#inbox

wait 2
//click //*[@email="no-reply@wogaa.sg"]/ancestor-or-self::tr
//click //input[@placeholder='Search in mail']
//type //input[@placeholder='Search in mail'] as WOGAA - Daily Sentiments Report (Singapore Student Learning Space (SLS)) [enter]
//live
// assume the email comes from me
// need to change to sender email to David_Lau@moe.gov.sg
click //*[@email="wee_loo_kang@moe.edu.sg"]/ancestor-or-self::tr
wait 3
//live
//click /html/body/div[7]/div[3]/div/div[2]/div[2]/div/div/div/div/div[2]/div/div[1]/div/div[2]/div/table/tr/td[1]/div[2]/div[2]/div/div[3]/div/div/div/div/div/div[1]/div[2]/div[3]/div[5]/div[4]/span[2]/a/div/div[3]/div[2]/div[2]/div/div[1]/span
//asume the second one is the html
//live
hover //a[contains(@data-tooltip,'daily-sentiments-report-')]
//live
read /html/body/div[7]/div[3]/div/div[2]/div[2]/div/div/div/div/div[2]/div/div[1]/div/div[2]/div/table/tr/td[1]/div[2]/div[2]/div/div[3]/div/div/div/div/div/div[1]/div[2]/div[3]/div[5]/div[4]/span[2]/a/div/div[3]/div[2]/div[2]/div/div[1]/span to temp

click (//div[@aria-label='Download attachment `temp`'])
echo sucess 2
wait 3