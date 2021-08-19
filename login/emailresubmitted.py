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
# change the message to whatever you like
my_msg = "The lesson has been detected as resubmitted!! <br/><br/>Dear CG Admin, <br/><br/>This is an automated email to alert you that the lesson is back in CG pending review tab, and need your kind help to return/publish this lesson ASAP please.  <br/><br/>Thank you.<br/><br/>Regards."


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

# change this variable to your email
our_email = "" # appears not needed

def gmail_authenticate():
    creds = None
    # the file token.pickle stores the user's access and refresh tokens, and is
    # created automatically when the authorization flow completes for the first time
    if os.path.exists("token.pickle"):
        with open("token.pickle", "rb") as token:
            creds = pickle.load(token)
    # if there are no (valid) credentials availablle, let the user log in.
    if not creds or not creds.valid:
        if creds and creds.expired and creds.refresh_token:
            creds.refresh(Request())
        else:
            flow = InstalledAppFlow.from_client_secrets_file(os.path.join(CURR_DIR,'credentials.json'), SCOPES)
            creds = flow.run_local_server(port=0)
        # save the credentials for the next run
        with open("token.pickle", "wb") as token:
            pickle.dump(creds, token)
    return build('gmail', 'v1', credentials=creds)

# get the Gmail API service
service = gmail_authenticate()

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
    if parts:
        for part in parts:
            mimeType = part.get("mimeType")
            if(mimeType == "text/html"):
                body = part.get("body")
                data = body.get("data")
                print(data)
                if data:
                    text = base64.urlsafe_b64decode(data).decode()
                    print(f"quoted text: {text}")
    return text

def read_message(service, message_id):
    msg = service.users().messages().get(userId='me', id=message_id['id'], format='full').execute()
    # parts can be the message body, or attachments
    payload = msg['payload']
    headers = payload.get("headers")
    parts = payload.get("parts")
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
    # match = re.search(r"Before (\d+) (\w+) (\d+)$", subject)
    # if match:
    #     today = date.today()
    #     d1 = date(int(today.strftime("%y")),int(today.strftime("%m")),int(today.strftime("%d")))
    #     d2 = date(int(match.group(3)),convertMonth(match.group(2)[:3]),int(match.group(1)))
    #     print(f"comparing {d1} with {d2}")
    #     if(d2 < d1):
    # send chaser email
    quote = getQuote(parts)
    subject = f"Re: {subject}"
    msgappended = f"{my_msg} <br/><br/>--- Original Message ---<br/>{quote}"
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

search_strings = []
# get search strings from file
pendinglist = os.path.join(CURR_DIR, "pendingreview_list.csv")
with open(pendinglist, encoding="utf8") as file:
    for row in csv.reader(file):
        # check if resubmitted ==1
        if(row[10] == "1"):
            url = row[8]
            print(f"extracting search string from url {url}...")
            match = re.search(r"\/view\/(.+)\/cover", url)
            if match:
                search_strings.append(match.group(1))
                print(f"extracted search string {match.group(1)}")
print(search_strings)

# get emails that match the query you specify
if testing:
    search_strings = ["testing123"]
elif len(search_strings) < 1:
    print("no records found")
    exit()
for query in search_strings:
    results = search_messages(service, query)
    for msg in results:
        read_message(service, msg)
        # break after 1 iteration to avoid double emails
        break