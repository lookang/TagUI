#
# install dependencies 
import csv
import os

# change these paths according to where your files are
CURR_DIR = os.path.dirname(os.path.realpath(__file__))
pendingfile = os.path.join(CURR_DIR, "pendingreview_list.csv")
completedfile = os.path.join(CURR_DIR, "Subject Grps for Tracking_05Feb - 2021_Lessons.csv")
destination = os.path.join(CURR_DIR,"output.csv")

# set vars
pending = []
completed = []

# encoding="utf8" to support chinese 
with open(pendingfile, encoding="utf8") as file: 
    reader = csv.reader(file, delimiter=',')
    for row in reader: 
        # to aviod the first title row with name
        if(row[1] != "Title"):
            if(row[6] != ""):
                # to make comparision between July and Jul for example, to make same first
                # 11-jul-21
                # 01-aug-21
                # date = row[6][:row[6].find("-")].split()[0]+"-"+row[6][row[6].find("-")+1:].split()[0][:3].lower()+"-"+row[6][-2:]
                date = row[6][:row[6].find(" ")].split()[0]+"-"+row[6][row[6].find(" ")+1:].split()[0][:3].lower()+"-"+row[6][-2:]

                # 14-
                # date = date  +row[6][row[6].find("-")+1:]
            else:
                # leave it as blank
                date = ""
            pending.append((row[1],date)) # store the title and date in pending list
            print(f"row {row[0]}: {row[1]}, {date}")

with open(completedfile, encoding="utf8") as file:
    reader = list(csv.reader(file, delimiter=','))
    count = 0
    for row in reader: 
        if(row[1] != "Title" or row[1] != ""):
            count += 1
            if(row[6] != ""):
                date = row[6][:row[6].find("-")].split()[0]+"-"+row[6][row[6].find("-")+1:].split()[0][:3].lower()+"-"+row[6][-2:]
            else: 
                date = ""
            completed.append((row[1],date))
            #print(f"Completed list: row {count}: {row[1]}, {row[6]}")

#frozenset prevent edits to it
pendingset = frozenset(pending)
print(pendingset)
# x is a variable
result = [x for x in completed if x in pendingset]
if(len(result) < 1):
    # no element found
    print("no matches found")
    exit()
print("list of matches: ")
#list of matches: 

for i in result: 
    print(f"{i[0]} , {i[1]}")
    #print(f"{i[0]} - {i[1]}")
    #Sec 2 Historical Investigation: Virtual LJ - 30-jun-21
    #二年级：第十五课《这些我都爱吃》 - 10-jul-21
    #How does climate change affect people and the environment? - 11-jul-21
    #The Weimar Golden Years- You did Nazi it coming - 11-jul-21
# +2 offset to consider the title line and the way indexes are counted from 0, and to exclude the match itself
print(f"result[-1]= {result[-1]}")
index = pending.index(result[-1])+1
print(f"index of last match: {index}")
# output could be like index of last match: 18
print("deleting everything above last result of intersection...")
#input is reserve name, so using inp
with open(pendingfile, 'r', encoding="utf8") as inp:
    lines = inp.readlines()
with open(destination, 'w', encoding="utf8") as out: 
    # : is a below the index
    out.writelines([row for row in lines[(index+1):]])
print(f"saved to {destination}")