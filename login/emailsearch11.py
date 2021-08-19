# references:
# https://www.thepythoncode.com/article/use-gmail-api-in-python
# https://stackoverflow.com/questions/55984521/how-correctly-set-in-reply-to-and-reference-headers-in-gmail-api
# https://developers.google.com/gmail/api/guides/sending

"""
Variables you can edit
"""
# change this to turn on/off testing mode (search for test string instead of real data)
testing = False
# change this to toggle between reply and reply to all
reply_all = True
# change this to toggle between saving the counter in csv file or searching messages to get the count
track_count_csv = False
# change the message to whatever you like
my_msg =    "This automated message has been sent {counter} {times}.<br/><br/>\
            Dear CG Admin, <br/><br/>\
            This lesson has been detected as LATE for review. This email serves as a gentle reminder to return/publish this lesson by today or next working day please. This is in view of the Public Service Service Commitment 5 working days https://www.psd.gov.sg/who-we-are/our-service-commitment <br/><br/>\
            Thank you.<br/><br/>\
            Regards."
# change the file name of your pending list if necessary
pendingfile = "pendingreview_list.csv"

import base64
import os
import pickle
import csv
import re
from datetime import *
# Gmail API utils
from googleapiclient.discovery import build
from google_auth_oauthlib.flow import InstalledAppFlow
from google.auth.transport.requests import Request
# for encoding/decoding messages in base64
# from base64 import urlsafe_b64decode, urlsafe_b64encode
# for dealing with attachement MIME types
from email.mime.text import MIMEText

# Request all access (permission to read/send/receive emails, manage the inbox, and more)
SCOPES = ['https://mail.google.com/']
CURR_DIR = os.path.dirname(os.path.realpath(__file__))
pendinglist = os.path.join(CURR_DIR, pendingfile)

# change this variable to your email
our_email = "" # appears not needed

def gmail_authenticate():
    creds = None
    # the file token.pickle stores the user's access and refresh tokens, and is
    # created automatically when the authorization flow completes for the first time
    if os.path.exists(os.path.join(CURR_DIR,"token.pickle")):
        print("retrieving token")
        with open("token.pickle", "rb") as token:
            creds = pickle.load(token)
    # if there are no (valid) credentials availablle, let the user log in.
    if not creds or not creds.valid:
        if creds and creds.expired and creds.refresh_token:
            print("refreshing request")
            creds.refresh(Request())
        else:
            flow = InstalledAppFlow.from_client_secrets_file(os.path.join(CURR_DIR,'credentials.json'), SCOPES)
            creds = flow.run_local_server(port=0)
        # save the credentials for the next run
        with open(os.path.join(CURR_DIR, "token.pickle"), "wb") as token:
            pickle.dump(creds, token)
    return build('gmail', 'v1', credentials=creds)

# get the Gmail API service
service = gmail_authenticate()

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

def search_messages(service, query):
    result = service.users().messages().list(userId='me',q="in:sent "+query).execute()
    messages = [ ]
    if 'messages' in result:
        messages.extend(result['messages'])
    while 'nextPageToken' in result:
        page_token = result['nextPageToken']
        result = service.users().messages().list(userId='me',q=query, pageToken=page_token).execute()
        if 'messages' in result:
            messages.extend(result['messages'])
    return messages

def get_mime_message(service, user_id, msg_id):
    try:
        message = service.users().messages().get(userId=user_id, id=msg_id,
                                                 format='raw').execute()
        msg_str = base64.urlsafe_b64decode(message['raw']).decode()
        mime_msg = message.message_from_string(msg_str)
        return mime_msg
    except:
        print("An error occurred")

def getQuote(parts):
    # gets body of previous message to be quoted in new email
    text = ""
    if "data" in parts["body"]:
        data = parts["body"]["data"]
        text = base64.urlsafe_b64decode(data).decode()
    elif parts:
        try:
            for i in parts["parts"]:
                if(i["body"]["data"]):
                    data = i["body"]["data"]
                    print(f"data found in 0th check.")
                    if data:
                        text = base64.urlsafe_b64decode(data).decode()
                        continue
        except: 
            for part in parts:
                try: 
                    data = part["body"]["data"]
                    print(f"data found in 1st check.")
                    if data:
                        text = base64.urlsafe_b64decode(data).decode()
                        continue
                except:
                    data = part[0]["body"]["data"]
                    print(f"data found in 2nd check.")
                    if data:
                        text = base64.urlsafe_b64decode(data).decode()
                        continue
                finally:
                    print("data not found.")
                    continue
    print(f"quoted text: {text}")
    return text

def read_message(service, message_id, counter):
    msg = service.users().messages().get(userId='me', id=message_id['id'], format='full').execute()
    # parts can be the message body, or attachments
    payload = msg['payload']
    headers = payload.get("headers")
    parts = payload.get("body")
    to = ""
    subject = ""
    cc = ""
    if headers:
        # this section prints email basic info & creates a folder for the email
        for header in headers:
            name = header.get("name")
            value = header.get("value")
            if name.lower() == "to":
                # we print the To address
                to = value
                print("To:", value)
            if name.lower() == "subject":
                subject = value
                print("Subject:", value)
            if reply_all:
                if name.lower() == "cc":
                    # reply to all
                    cc = value
                    print("CC:", value)
    match = re.search(r"Before (\d+) (\w+) (\d+)$", subject)
    if match:
        today = date.today()
        # account for year formatting e.g. 2021 inputted as 21
        yr = int(match.group(3))
        if yr < 2000:
            yr += 2000
        d1 = date(int(today.strftime("%Y")),int(today.strftime("%m")),int(today.strftime("%d")))
        d2 = date(yr,convertMonth(match.group(2)[:3]),int(match.group(1)))
        print(f"comparing {d1} with {d2}")
        if(d2 < d1):
            # send chaser email
            quote = getQuote(payload)
            if not track_count_csv:
                # search for the number of times this message has been sent using regex. and add 1 to it
                match = re.search(r"This automated message has been sent (\d+) time", quote)
                if match:
                    counter = int(match.group(1))+1
                else:
                    counter = 0
            subject = f"Re: {subject}"
            # this replaces {counter} {times} in the original message and makes it gramatically correct
            replaceText = str(counter)+(' time' if int(counter)==1 else ' times')
            msgappended = f"{my_msg.replace('{counter} {times}', replaceText)} <br/><br/>--- Original Message ---<br/>{quote}"
            print("-"*50)
            message = create_message(subject, to, cc, msgappended, message_id['threadId'], message_id['id'])
            send_message(service, "me", message)

def create_message(subject, recipients, cc, my_msg, threadID, msgID):
    print(f"sending new message...")
    cc_text = ""
    if cc!="":
        cc_text = f"CC: {cc}\n"
    print(f"Subject: {subject}\nTo: {recipients}\n{cc_text}Message: {my_msg}\nThreadID: {threadID}\nMsgID: {msgID}")
    print("="*50)

    message = MIMEText(my_msg, 'html')
    message['to'] = recipients
    if cc!="":
        message['cc'] = cc
    message['from'] = our_email
    message['subject'] = subject
    message.add_header('Reference', msgID)
    message.add_header('In-Reply-To', msgID)
    raw_msg = {'raw': (base64.urlsafe_b64encode(message.as_bytes()).decode())}
    raw_msg['threadId'] = threadID
    return raw_msg

def send_message(service, user_id, message):
  """Send an email message.

  Args:
    service: Authorized Gmail API service instance.
    user_id: User's email address. The special value "me"
    can be used to indicate the authenticated user.
    message: Message to be sent.

  Returns:
    Sent Message.
  """
  try:
    message = (service.users().messages().send(userId=user_id, body=message)
               .execute())
    print('Message sent! Id: %s' % message['id'])
    return message
  except:
    print("error")

'''
    don't need to use this if not tracking counter through the csv file
'''
# define a temp file for intermediary workings
temp = os.path.join(CURR_DIR, "tempdump.csv")
def addCounter():
    # adds a counter to the csv and saves the file
    with open(pendinglist, 'r', encoding="utf8") as inp, open(temp, 'w', encoding="utf8", newline='') as out:
        reader = csv.reader(inp)
        writer = csv.writer(out)
        for row in reader:
            if row[0] == "S/N":
                if row[-1] != "Counter":
                    row.append("Counter")
            else:
                if not row[-1].isdigit():
                    row.append("0")
            writer.writerow(row)
    return True

search_strings = []
if track_count_csv:
    counters = []
# get search strings from file
with open(pendinglist, encoding="utf8") as file:
    c = None
    for row in csv.reader(file):
        if track_count_csv:
            # add counter column if not exist
            if(row[0] == "S/N"):
                if(row[-1] != "Counter"):
                    c = addCounter()
            if c:
                counters.append("0")
            else: 
                if(row[-1].isdigit()):
                    counters.append(row[-1])
        url = row[8]
        print(f"extracting search string from url {url}...")
        match = re.search(r"\/view\/(.+)\/cover", url)
        if match:
            search_strings.append(match.group(1))
            print(f"extracted search string {match.group(1)}")
print(search_strings)

if track_count_csv:
    # cleanup
    if os.path.exists(temp):
        # delete the original pending file
        os.remove(pendinglist)
        # rename the temp file to pending name
        os.rename(temp, os.path.join(CURR_DIR, pendingfile))

# get emails that match the query you specify
if testing:
    search_strings = ["testing123"]
    if track_count_csv:
        counters = ["1"]
for i, query in enumerate(search_strings):
    results = search_messages(service, query)
    for msg in results:
        read_message(service, msg, counters[i] if track_count_csv else "")
        # break after 1 iteration to avoid double emails
        break