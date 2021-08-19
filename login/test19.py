#
# install dependencies 
import csv
import os
import re

# regex functions
def convertDate(date):
    print(f"converting {date}...")
    # check date not contains digit (invalid)
    if not(re.compile("\d").match(date)):
        print(f"\t{date} does not contain a digit. skipping...")
        return ""
    # check date matches format 1-Jan-21
    if(re.compile("\d+\-\w+\-\d+").match(date)):
        print(f"\t{date} in the format 1-Jan-21")
        out = date.split("-")[0].lstrip('0')+"-"+str(convertMonth(date[date.find("-")+1:].split()[0][:3].lower()))+"-"+date[-2:]
        print(f"\tconverted {date} to {out}")
        return out
    # check date matches format 1 Jan 21
    if(re.compile("\d+ \w+ \d+").match(date)):
        print(f"\t{date} in the format 1 Jan 21")
        out = date.split(" ")[0].lstrip('0')+"-"+str(convertMonth(date[date.find(" ")+1:].split()[0][:3].lower()))+"-"+date[-2:]
        print(f"\tconverted {date} to {out}")
        return out
    # check date matches format 1/1/21
    if(re.compile("\d+\/\d+\/\d+").match(date)):
        print(f"\t{date} in the format 1/1/21")
        out = date.split("/")[0].lstrip('0')+"-"+date.split("/")[1]+"-"+date[-2:]
        print(f"\tconverted {date} to {out}")
        return out
    # anything else leave blank
    return ""

def convertMonth(month):
    ### expected input: 3-letter month case insensitive
    month = month.lower();
    if(month == "jan"):
        return 1
    if(month == "feb"):
        return 2
    if(month == "mar"):
        return 3
    if(month == "apr"):
        return 4
    if(month == "may"):
        return 5
    if(month == "jun"):
        return 6
    if(month == "jul"):
        return 7
    if(month == "aug"):
        return 8
    if(month == "sep"):
        return 9
    if(month == "oct"):
        return 10
    if(month == "nov"):
        return 11
    if(month == "dec"):
        return 12
    return 0

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
    reader = csv.reader(file)
    for row in reader: 
        date = convertDate(row[6])
        pending.append((row[1],date)) # store the title and date in pending list
        print(f"row {row[0]}: {row[1]}, {date}")

with open(completedfile, encoding="utf8") as file:
    reader = list(csv.reader(file))
    for count, row in enumerate(reader): 
        if(row[1] != "Title" or row[1] != ""):
            date = convertDate(row[6])
            completed.append((row[1],date))
            #print(f"Completed list: row {count}: {row[1]}, {row[6]}")

#frozenset prevent edits to it
pendingset = frozenset(pending)
print(pendingset)

# x is a variable
result = [x for x in completed if x in pendingset]
if(len(result) < 1):
    # no element found
    print("no matches found, rewriting output.csv as blank")
    os.chmod(destination, 0o777)
    try:
        os.remove(destination)
        with open(destination, 'w'):
            pass
    except OSError as e:
        print("Error rewriting %s : %s" % (destination, e.strerror))
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
print(f"result[-1]= {result[-1]}")
index = pending.index(result[-1])
print(f"index of last match: {index}")
# output could be like index of last match: 18
print("deleting everything above last result of intersection...")
#input is reserve name, so using inp
output = []
with open(pendingfile, 'r', encoding="utf8") as inp, open(destination, 'w', encoding="utf8", newline='') as out:
    reader = csv.reader(inp)
    output.append(["S/N","Title","Type","Subject","Level","School","Date Submitted","Author","URL","Similar","Resubmitted","Assigned To","Date Lesson Assigned","Due Date","Duplicate","Similar To","Email of Admin"])
    for i, row in enumerate(reader):
        print(f"reading row {i}: {row[1]}")
        if(i > index):
            print(f"adding row {i} to output...")
            output.append(row)
    writer = csv.writer(out)
    for row in output:
        writer.writerow(row)

print(f"saved to {destination}")