# script by kensoh
# https://github.com/kelaberetiv/TagUI/issues/1093#issuecomment-899311215
# slight edits by lookang

import pandas as pd
import rpa as r
result2 = r.ask('type 1 for turbo_mode, type 0 for normal speed')
if (result2 == "1"):
    r.init(turbo_mode = True); 
elif (result2 == "0"):
    r.init(turbo_mode = False); 
r.url('https://developer.automationanywhere.com/challenges/automationanywherelabs-supplychainmanagement.html')

#result = r.ask('type 1 for download xls, type 0 for no need')
#if (result == "1"):
# file xls is different every time it downloads
r.click('Download Agent Territory Spreadsheet')

df = pd.read_excel('StateAssignments.xlsx')
po_numbers = []
for n in range (7):
    po_numbers.append(r.read('#PONumber' + str(n+1)))
    print(po_numbers)
# need to manually set TagUI Chrome browser to allow pop-up redirects
r.dom('window.open("https://developer.automationanywhere.com/challenges/AutomationAnywhereLabs-POTrackingLogin.html")')
# need to save email and password onto the browser saved passwords separately
# admin@procurementanywhere.com
# paypacksh!p
r.popup('POTracking')
r.click('(//button)[1]')

orders_list = []
for n in range(7):
    r.type('//input[@type = "search"]', '[clear]' + po_numbers[n])
    state = r.read('(//table//td)[5]')
    ship_date = r.read('(//table//td)[7]')
    order_total = r.read('(//table//td)[8]')
    orders_list.append([state, ship_date, order_total])
    print(orders_list[n])

# need to close window to snap correct main page 
r.dom('window.close("https://developer.automationanywhere.com/challenges/AutomationAnywhereLabs-POTrackingLogin.html")')

# if 2nd tab window is closed, r.popup is not required
r.popup('supplychainmanagement')
for order in range(7):
    r.type('#shipDate' + str(order+1), orders_list[order][1])
    r.type('#orderTotal' + str(order+1), orders_list[order][2][1:])
    agent_name = df.loc[df['State'] == orders_list[order][0]].iloc[0]['Full Name']
    r.select('#agent' + str(order+1), agent_name)

# r.click('submitbutton')
r.click('//*[@id="submitbutton"]')
r.wait()
r.snap('page', 'week2results.png')
r.close()