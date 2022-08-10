import pandas as pd
# https://datatofish.com/csv-to-excel-python/
# for windows
# path = '/Users/lookang/Desktop/tagui/flows/jamson/csvtoxlsx/'
# https://stackoverflow.com/questions/7099290/how-to-ignore-hidden-files-using-os-listdir
# error created when this is a '.DS_Store -- UnicodeDecodeError: 'utf-8' codec can't decode byte 0xb7 in position 551: invalid start byte
import os
def listdir_nohidden(path):
    for f in os.listdir(path):
        if not f.startswith('.'):
            yield f
# will need to replace user name 'lookang' to specific mac machines say jamson or what the machine user is 
lookang = 'lookang'

arr = listdir_nohidden('/Users/'+lookang+'/Desktop/tagui/flows/jamson/csvtoxlsx/')
print (arr)
#https://stackoverflow.com/questions/3207219/how-do-i-list-all-files-of-a-directory
#import os
#arr = os.listdir('/Users/lookang/Desktop/tagui/flows/jamson/csvtoxlsx/')
#print (arr)

# also need to assume tagui is saved in /Desktop/tagui/
for val in arr:
    #for mac
    read_file = pd.read_csv (r'/Users/'+lookang+'/Desktop/tagui/flows/jamson/csvtoxlsx/'+val)
    read_file.to_excel (r'/Users/'+lookang+'/Desktop/tagui/flows/jamson/csvtoxlsxout/'+val+'.xlsx', index = None, header=True)

