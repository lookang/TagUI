# script by kensoh
# https://github.com/kelaberetiv/TagUI/issues/1093#issuecomment-894973771
# slight edits by lookang
# 
# pip install rpa --upgrade
# turbo_mode = True avaliable after upgrade

import pandas as pd
import rpa as r

r.init(chrome_browser = True, visual_automation = True, headless_mode = False, turbo_mode = True)
# turbo_mode = True is 14 sec, without is 100+ sec
r.url('https://developer.automationanywhere.com/challenges/automationanywherelabs-customeronboarding.html')

r.click('Download CSV')
df = pd.read_csv('MissingCustomers.csv')
df['Zip'] = df['Zip'].astype(str)

for i in range(len(df.axes[0])):
    r.type('customerName', df['Company Name'][i])
    r.type('customerID', df['Customer ID'][i])
    r.type('primaryContact', df['Primary Contact'][i])
    r.type('street', df['Street Address'][i])
    r.type('city', df['City'][i])
    r.select('state', df['State'][i])
    r.type('zip', df['Zip'][i].zfill(5))
    r.type('email', df['Email Address'][i])
    r.click('activeDiscount' + df['Offers Discounts'][i].capitalize())
    if df['Non-Disclosure On File'][i] == 'YES': r.click('NDA')
    r.click('Register')

r.wait()
r.snap('page', 'week1s1results.png')
r.close()