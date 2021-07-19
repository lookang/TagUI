# script by kyrin

# need to install gspread if not already installed
# for python3
# pip3 install gspread

import gspread
import csv
import os

# https://stackoverflow.com/questions/40781295/how-to-find-the-first-empty-row-of-a-google-spread-sheet-using-python-gspread/42476314#42476314
# to find the first empty row, example
def next_available_row(worksheet):
    str_list = list(filter(None, worksheet.col_values(1)))
    return str(len(str_list)+1)

# get current local working directory
dir = os.path.dirname(os.path.realpath(__file__))

# put here the filepath of your client_secret.json
# this file client_secret.json is secret and cannot be shared.
client_secret = os.path.join(dir,"client_secret.json")

newlines = []
# read output.csv
with open(os.path.join(dir,"output.csv"), encoding="utf8") as file:
    reader = csv.reader(file, delimiter=',')
    for row in reader:
        newlines.append(row)

# connect to google api with service account and client_secret credentials
gc = gspread.service_account(filename=client_secret)

# select spreadsheet by key
sh = gc.open_by_key("1BLkzGm8t_e98i4bztpxJsGdLA_EVD6WZ5W4oPpwjxg0")
#sh = gc.open("Subject Grps for Tracking_05Feb")

# select sheet 2021_Lessons
worksheet = sh.worksheet("2021_Lessons")
# find the last row of data
next_row = next_available_row(worksheet)

print(f"inserting values at row {next_row}")
#inserting values at row 1498 
worksheet.insert_rows(  newlines, 
                        row=int(next_row), 
                        value_input_option='USER_ENTERED'   )
print("data inserted")