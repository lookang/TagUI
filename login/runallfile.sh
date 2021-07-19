tagui loginsls3.tag        

# might need to change to if you have other python version in my computer 
#python test11.py
#for me, i like to specific the version cos i had python3.8 also, messing up
# read https://weelookang.blogspot.com/2021/07/how-to-remove-anaconda-python-38-from.html 
# cannot upgrade to test12 as it stops on 15 july but not add the rest like 16 july
python3.9 test11.py

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
