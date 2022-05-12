# script by kensoh
# https://github.com/kelaberetiv/TagUI/issues/1093#issuecomment-894973771
# slight edits by lookang

import pandas as pd
import rpa as r
import time

r.init(turbo_mode=True)
r.url('https://developer.automationanywhere.com/challenges/automationanywherelabs-customeronboarding.html')

df = pd.read_csv('MissingCustomers.csv')
df['Zip'] = df['Zip'].astype(str)

# simple manual delay to avoid overheads of initial communication with browser
time.sleep(2)

dom_query = "document.querySelector('[role = \"button\"]');" + "data = [[],[],[],[],[],[],[],[],[],[]];"
for i in range(7):
    dom_query += "data[" + str(i) + "][1]='" + df['Company Name'][i] + "';"
    dom_query += "data[" + str(i) + "][2]='" + df['Customer ID'][i] + "';"
    dom_query += "data[" + str(i) + "][3]='" + df['Primary Contact'][i] + "';"
    dom_query += "data[" + str(i) + "][4]='" + df['Street Address'][i] + "';"
    dom_query += "data[" + str(i) + "][5]='" + df['City'][i] + "';"
    dom_query += "data[" + str(i) + "][6]='" + df['State'][i] + "';"
    dom_query += "data[" + str(i) + "][7]='" + df['Zip'][i].zfill(5) + "';"
    dom_query += "data[" + str(i) + "][8]='" + df['Email Address'][i] + "';"
    dom_query += "data[" + str(i) + "][9]='" + df['Offers Discounts'][i].capitalize() + "';"
    dom_query += "data[" + str(i) + "][10]='" + df['Non-Disclosure On File'][i] + "';"

dom_query += "for (i=0;i<7;i++){";
dom_query += "document.querySelector('#customerName').value=data[i][1];"
dom_query += "document.querySelector('#customerID').value=data[i][2];"
dom_query += "document.querySelector('#primaryContact').value=data[i][3];"
dom_query += "document.querySelector('#street').value=data[i][4];"
dom_query += "document.querySelector('#city').value=data[i][5];"
dom_query += "document.querySelector('#state').value=data[i][6];"
dom_query += "document.querySelector('#zip').value=data[i][7];"
dom_query += "document.querySelector('#email').value=data[i][8];"
dom_query += "document.querySelector('#activeDiscount'+data[i][9]).click();"
dom_query += "if (data[i][10]=='YES') document.querySelector('#NDA').click();"
dom_query += "document.querySelector('#submit_button').click();}"
r.dom(dom_query)

r.wait()
r.snap('page', 'week1s2results.png')
r.close()