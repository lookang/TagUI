# To run, type in terminal
# python crawlSyllabusFromContentMap.py

# To use the folder called folderpython to create the csv files.
# create it first './folderpython/{}.csv'.format(title))


# import tagui python library
import rpa as r

# Navigate to the SLS login page
r.init(visual_automation=True)
r.url("https://vle.learning.moe.edu.sg/login")
r.wait(3)

# Ask for SLS (1) or MIMS (2) login
ask_result = 1  # Set your choice here
r.echo(ask_result)

if ask_result == 1:
    if r.exist('//button[normalize-space()="Login With SLS"]'):
        r.click('//button[normalize-space()="Login With SLS"]')
    if r.exist("//button[normalize-space()='Login']"):
        r.click("//button[normalize-space()='Login']")
elif ask_result == 2:
    if r.exist("//button[normalize-space()='Login With MIMS']"):
        r.click("//button[normalize-space()='Login With MIMS']")
        r.wait(3)
        r.click(r.read('(//span[@id="loginButton2"])[1]'))

r.wait(2)
r.url("https://vle.learning.moe.edu.sg/manage-resource?resource=CONTENTMAP")
r.wait(2)

# give a initial value to define total incase cannot get from webpage
total = 20
# Get the total number of rows
if r.exist('//div[@class="v-data-footer__pagination"]'):
    pagination = r.read('//div[@class="v-data-footer__pagination"]')
    total = int(pagination.split("of")[1].strip())
    r.echo(f"There are {total} number of lessons.")

r.wait(2)
tableCnt = 6
rowCnt = 6

for i in range(1, total - tableCnt * 20):
    for m in range(1, tableCnt):
        r.click('//button[@aria-label="Next page"]')
        r.wait(1)
    link = ""

    r.click('(//a[contains(text(),"Open")])[{}]'.format(rowCnt))
    r.popup('contentmap/view/')
    r.wait(1)
    link = r.url()
    r.echo("link = {}".format(link))
    r.dom('window.close()')

    # popup()	string_in_url (no parameter to reset to main page)
    r.popup()
    r.url(link)
    r.wait(1)

    if r.exist('//a[@id="learning-outcomes-link"]'):
        r.click('//a[@id="learning-outcomes-link"]')
        r.wait(1)
        title = r.read('//div[@class="title-wrapper"]//h4[@class="title"]')
        endTreeAnchor = r.count('(//span[@class="tree-anchor"])')

        for j in range(1, endTreeAnchor):
            if r.exist('(//span[@class="tree-anchor"])'):
                text = r.read('(//span[@class="tree-anchor"])[{}]'.format(j))
                r.echo('{} is {}'.format(j, text))
                title = title.replace('/', ' ')
                r.write('{}\n'.format([j, text]), './folderpython/{}.csv'.format(title))

    r.url("https://vle.learning.moe.edu.sg/manage-resource?resource=CONTENTMAP")
    rowCnt += 1
    if rowCnt == 21:
        tableCnt += 1
        r.echo('tableCnt = {}'.format(tableCnt))
        rowCnt = 1
        r.wait(2)

r.close()
