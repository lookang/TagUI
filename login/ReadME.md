#Note:
#Prepare:
#emails.csv need to be populate with real data
#body_template.txt need to be edited to suit your needs

#Blog
#https://weelookang.blogspot.com/2021/07/almost-full-automation-using-tagui-and.html

#Run first or the latest working file
#a new file will be generated after crawling SLS pending review
tagui loginsls4.tag        

# might need to change to if you have other python version in my computer 
#python test11.py
#for me, i like to specific the version cos i had python3.8 also, messing up
# read https://weelookang.blogspot.com/2021/07/how-to-remove-anaconda-python-38-from.html 
# cannot upgrade to test12 as it stops on 15 july but not add the rest like 16 july
python3.9 test19.py



# send auto emails to remind officers to review their resubmitted lessons if resubmitted column in pendingreview_list.csv=1
python3.9 emailresubmitted.py


# send these first to search through lesser emails instead of after compose_mail.tag 
# send auto emails to remind officers to review their sssigned lessons if the date today is longer to the emails date.
python3.9 emailsearch11.py




tagui compose_mail.tag 

# clean up
# copy output.csv to the https://docs.google.com/spreadsheets/d/1BLkzGm8t_e98i4bztpxJsGdLA_EVD6WZ5W4oPpwjxg0/edit#gid=2115702978
# look for empty A about 1488 and paste in the data to 
python3.9 sheets.py 

# download files
# download 2021_Lessons i think tagui can do
# download emails 
# didnt work for emails, compuer vision not accurate?
tagui copyoutfromsheettofolder.tag 



#End.

Update 20220314
Whole of Government TagUI flow
double click one file called runallwog.cmd
call tagui loginsls4wog.tag && python test19.py && tagui compose_mailwog.tag && tagui sheets.tag && tagui copyoutfromsheettofolderwog.tag

#data extract working
https://www.youtube.com/watch?v=j-ABoO5aR0o
https://github.com/lookang/TagUI/blob/main/login/loginsls4wog.tag

# produce output.csv
python test19.py


#compose email working
tagui compose_mailwog.tag
https://github.com/lookang/TagUI/blob/main/login/compose_mailwog.tag
https://www.youtube.com/watch?v=LL9BK28Di4k

#sheets_replacewog.tag to ovecome lack of computer vision, use human to copy paste download etc


#sheets.py remade in tag, but not working if not computer vision
https://www.youtube.com/watch?v=LQcniJ9A4gc
tagui sheets.tag

tagui copyoutfromsheettofolderwog.tag but not working if not computer vision
# not so working well, WOG does not allow downloading so the workaround is run on personal computer and email the 2 needed files
Subject Grps for Tracking_05Feb - emails.csv
Subject Grps for Tracking_05Feb - 2022_Lessons.csv


# emailsearch3.tag also not working, cannot triger search easily, need to debug why probably duw to the weakwe search in wogmail.
need to use slscgbot@gmail.com as google gmail can find the lessons by URL