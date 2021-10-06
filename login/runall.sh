# crawl SLS and produce pendingreviewlist.csv
#dependent on Subject Grps for Tracking_05Feb - 2021_Lessons.csv
#Subject Grps for Tracking_05Feb - emails.csv
#tagui loginsls6.tag  
tagui /Users/lookang/Desktop/tagui/flows/lookang/20210707/loginsls6.tag      

# might need to change to if you have other python version in my computer 
#python test11.py
#for me, i like to specific the version cos i had python3.8 also, messing up
# read https://weelookang.blogspot.com/2021/07/how-to-remove-anaconda-python-38-from.html 
# cannot upgrade to test12 as it stops on 15 july but not add the rest like 16 july
# copy part of pendingreviewlist.csv to output.csv
# dependent pendingreviewlist.csv
#dependent on Subject Grps for Tracking_05Feb - 2021_Lessons.csv
#python3.9 test19.py
python3 /Users/lookang/Desktop/tagui/flows/lookang/20210707/test19.py
# produce output.csv

# send these first to search through lesser emails instead of after compose_mail.tag 
# send auto emails to remind officers to review their sssigned lessons if the date today is longer to the emails date.
# depend on pendingreviewlist.csv
# gmail slscgbot@gmail.com
#python3.9 emailsearch11.py


# send auto emails to remind officers to review their resubmitted lessons if resubmitted column in pendingreview_list.csv=1
# depend on pendingreviewlist.csv
# gmail slscgbot@gmail.com
#python3.9 emailresubmitted2.py






# depend on output.csv
# gmail slscgbot@gmail.com
#tagui compose_mail.tag 
tagui /Users/lookang/Desktop/tagui/flows/lookang/20210707/compose_mail.tag
# clean up
# copy output.csv to the https://docs.google.com/spreadsheets/d/1BLkzGm8t_e98i4bztpxJsGdLA_EVD6WZ5W4oPpwjxg0/edit#gid=2115702978
# look for empty A about 1488 and paste in the data to 
#depend on gsheet XLS
#python3.9 sheets.py 
python3 /Users/lookang/Desktop/tagui/flows/lookang/20210707/sheets.py


# download files
# download 2021_Lessons i think tagui can do
# download emails 
# didnt work for emails, compuer vision not accurate?
#depend on gsheet XLS
#tagui copyoutfromsheettofolder.tag 
tagui /Users/lookang/Desktop/tagui/flows/lookang/20210707/copyoutfromsheettofolder.tag 

#separate flow as tagui produce error if both URL are googlesheets
# tagui copyoutfromsheettofolder2.tag 
# produce Subject Grps for Tracking_05Feb - 2021_Lessons.csv
#produce Subject Grps for Tracking_05Feb - emails.csv

