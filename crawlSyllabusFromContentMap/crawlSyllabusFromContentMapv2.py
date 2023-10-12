import rpa as r

# Limitations and comments
# ...

# Navigate to the SLS login page
r.init(visual_automation=True)
r.url('https://vle.learning.moe.edu.sg/login')
r.wait(3)

# User input
ask_result = 1
r.echo(f'{ask_result}')

if ask_result == 1:
    if r.present('//button[normalize-space()="Login With SLS"]'):
        r.click('//button[normalize-space()="Login With SLS"]')
    if r.present("//button[normalize-space()='Login']"):
        r.click("//button[normalize-space()='Login']")
elif ask_result == 2:
    if r.present("//button[normalize-space()='Login With MIMS']"):
        r.click("//button[normalize-space()='Login With MIMS']")
        r.wait(3)
        r.click('(//span[@id="loginButton2"])[1]')

# Visit URL
r.wait(2)
r.url('https://vle.learning.moe.edu.sg/manage-resource?resource=CONTENTMAP')
r.wait(2)

# give a initial value to define total incase cannot get from webpage
total = 20

# Getting total number of rows
if r.present('//div[@class="v-data-footer__pagination"]'):
    pagination = r.read('//div[@class="v-data-footer__pagination"]')
    total = int(pagination.split("of")[1].strip())
    r.echo(f'There are {total} number of lessons.')

r.wait(2)
tableCnt = 0

# To prepare the page at the correct tableCnt
for m in range(1, tableCnt + 1):
    r.click('//button[@aria-label="Next page"]')

rowCnt = 1

# Live data extraction loop
for i in range(1, total - tableCnt * 20 + 1):
    link = ""

    # Click "Open" link
    r.click(f'(//a[contains(text(),"Open")])[{rowCnt}]')
    r.popup('contentmap/view/')
    r.wait(1)
    link = r.url()
    # Add "https://" to the beginning of the link
    link = 'https://' + link[8:]
    r.echo(f'link = {link}')
    
    r.click('//a[@id="learning-outcomes-link"]')
    r.wait(1)
    title = r.read('//div[@class="title-wrapper"]//h4[@class="title"]')

    endTreeAnchor = r.count('(//span[@class="tree-anchor"])')
    r.echo(f'endTreeAnchor = {endTreeAnchor}')

    for j in range(1, endTreeAnchor + 1):
        if r.present(f'(//span[@class="tree-anchor"])[{j}]'):
            text = r.read(f'(//span[@class="tree-anchor"])[{j}]')
            r.echo(f'{j} is {text}')
            title = title.replace('/', ' ')
            r.echo(title)
            r.write(text, f'./folderv4/{title}.csv')

    r.close()
    rowCnt += 1

    if rowCnt == 21:
        r.click('//button[@aria-label="Next page"]')
        tableCnt += 1
        r.echo(f'tableCnt = {tableCnt}')
        rowCnt = 1
        r.wait(2)

r.close()
