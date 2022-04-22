# originally from nived00015
# https://github.com/nived00015/-TagUi-for-Python-Data-Entry-RPA-Challenge-
# lookang modify this copy
import rpa as r
import pandas as pd
df = pd.read_excel('challenge.xlsx')
r.init(turbo_mode=True)
r.url("http://www.rpachallenge.com/")
#r.click("//button[@class='waves-effect col s12 m12 l12 btn-large uiColorButton']")
r.click ("//*[text()='Start']")
for i in df.index:
    r.type("//input[@ng-reflect-name='labelFirstName']",df['First Name'][i])
    r.type("//input[@ng-reflect-name='labelLastName']",df['Last Name '][i])
    r.type("//input[@ng-reflect-name='labelCompanyName']",df['Company Name'][i])
    r.type("//input[@ng-reflect-name='labelRole']",df['Role in Company'][i])
    r.type("//input[@ng-reflect-name='labelAddress']",df['Address'][i])
    r.type("//input[@ng-reflect-name='labelEmail']",df['Email'][i])
    r.type("//input[@ng-reflect-name='labelPhone']",str(df['Phone Number'][i]))
    
    #r.click("//input[@class='btn uiColorButton']")
    r.click("//*[@value='Submit']")
    

r.snap('page', 'results.png')
#r.wait(60)

r.close()
print("Python bot done data entry job...............................")
