# script by kensoh
# slightly edit by lookang
# https://github.com/kelaberetiv/TagUI/issues/1093#issuecomment-907996687

import rpa as r; 
# https://ocrmypdf.readthedocs.io/en/latest/installation.html
# for MacOS
# brew install ocrmypdf
import img2pdf; 
import os


result = r.ask('type 1 to run OCR files to create files in the folder, type 2 to run web inputs, type 0 to run all')
if (result == "1" or result == "0"):
    print(result)
    # 1. convert image files to pdf files to text files
    for filename in os.listdir('.'):
        if filename.endswith('.tiff'):
            # create pdf from tiff
            with open(filename + '.pdf', 'wb') as f: f.write(img2pdf.convert(filename))
            # https://ocrmypdf.readthedocs.io/en/latest/cookbook.html
            # this line not working, not producing the txt.
            r.run('ocrmypdf --sidecar ' + filename + '.txt ' + filename + '.pdf ' + filename + '.pdf')
            #r.run('ocrmypdf --sidecar ')
            #r.run('ocrmypdf --sidecar ' + filename + '.txt')
# 2. start Automation Anywhere RPA challenge page
# r.init(visual_automation = True, turbo_mode=True); 
if (result == "2" or result == "0"):
    print(result)
    result2 = r.ask('type 1 for turbo_mode with one error, type 0 for normal speed woth perfect score')
    if (result2 == "1"):
        r.init(visual_automation = True,turbo_mode = True); 
    if (result2 == "0"):
        r.init(visual_automation = True,turbo_mode = False); 
    r.url('https://developer.automationanywhere.com/challenges/automationanywherelabs-invoiceentry.html')
    # 3. process and enter invoices from OCR results
    for filename in os.listdir('.'):
        if filename.endswith('.tiff.txt'):
            if 'Ship to Invoice no.' in r.load(filename):
                ocr_text = r.get_text(r.load(filename), 'Invoice no.', 'Terms: ')
                ocr_line = ocr_text.split('\n')
                invoice_number = ocr_line[0].split(' ')[-1]
                invoice_date = ocr_line[2].split(' ')[-3] + ' ' + ocr_line[2].split(' ')[-2] + ' ' + ocr_line[2].split(' ')[-1]
                invoice_total = r.get_text(ocr_text + '$', 'Invoice Amount', '$')
                r.type('#invoiceNumber', invoice_number)
                r.type('#invoiceDate', invoice_date)
                r.type('#invoiceTotal', invoice_total.replace(',', ''))

                ocr_text = r.get_text(r.del_chars(ocr_text,'{}[]'), 'Tax Amount', 'Subtotal')
                ocr_line = ocr_text.split('\n')
                for item in range(len(ocr_line)):
                    
                    if ocr_line[item].count('|') == 1:
                        ocr_line[item] = ocr_line[item].replace(' G ', ' | G ')
                    quantity = ocr_line[item].split('|')[0].strip()
                    item_no = ocr_line[item].split('|')[1].strip().split(' ')[0]
                    description = ocr_line[item].split('|')[1].replace(item_no, '').strip()
                    unit_price = description.split(' ')[-1]
                    description = description.replace(unit_price, '').strip()
                    total_price = ocr_line[item].split('|')[-1].split(' ')[-1]
                    r.type('#quantity_row_' + str(item + 1), quantity)
                    r.type('#description_row_' + str(item + 1), description)
                    r.type('#price_row_' + str(item + 1), total_price.replace(',', ''))
                    if item != len(ocr_line) - 1:
                        r.click('//button')

                r.click('#fileupload')
                #r.wait(1.25)
                r.wait(2.25)
                if 'Invoice10' in filename: r.click('show_all2.png')
                r.keyboard(filename.replace('.tiff.txt', '') + '[enter]')
                r.click('#agreeToTermsYes')
                r.click('#submit_button')
                
            elif 'Sold to Ship to' in r.load(filename):
                ocr_text = r.load(filename)
                invoice_number = r.get_text(ocr_text, 'Invoice no.', 'Purchase Order')
                invoice_date = r.get_text(ocr_text, 'Invoice Date', 'Terms')
                invoice_total = r.del_chars(r.get_text(ocr_text, 'Invoice Amount', '\n'),'—=$, ')
                r.type('#invoiceNumber', invoice_number)
                r.type('#invoiceDate', invoice_date)
                r.type('#invoiceTotal', invoice_total)
                
                ocr_text = r.get_text(r.del_chars(ocr_text,'{}[]'), 'Tax Amount', 'Subtotal')
                ocr_line = ocr_text.split('\n')
                
                for item in range(len(ocr_line)):
                    if ocr_line[item].count('|') == 1:
                        ocr_line[item] = ocr_line[item].replace(' G ', ' | G ')
                    quantity = ocr_line[item].split('|')[0].strip()
                    item_no = ocr_line[item].split('|')[1].strip().split(' ')[0]
                    description = ocr_line[item].split('|')[1].replace(item_no, '').strip()
                    unit_price = description.split(' ')[-1]
                    description = description.replace(unit_price, '').strip()
                    total_price = ocr_line[item].split('|')[-1].split(' ')[-1]
                    r.type('#quantity_row_' + str(item + 1), quantity)
                    r.type('#description_row_' + str(item + 1), description)
                    r.type('#price_row_' + str(item + 1), total_price.replace(',', ''))
                    if item != len(ocr_line) - 1:
                        r.click('//button')

                r.click('#fileupload')
                r.wait(1.25)
                if 'Invoice10' in filename: r.click('show_all2.png')
                r.keyboard(filename.replace('.tiff.txt', '') + '[enter]')
                r.click('#agreeToTermsYes')
                r.click('#submit_button')
                
            elif 'Sold to Invoice no' in r.load(filename):
                ocr_text = r.load(filename)
                invoice_number = r.get_text(ocr_text, 'Invoice no.', '\n')
                invoice_date = r.get_text(ocr_text, 'Invoice Date', '\n')
                invoice_total = r.del_chars(r.get_text(ocr_text, 'Invoice Amount', '\n'),'—=$, ')
                r.type('#invoiceNumber', invoice_number)
                r.type('#invoiceDate', invoice_date)
                r.type('#invoiceTotal', invoice_total)

                ocr_text = r.get_text(r.del_chars(ocr_text,'{}[]'), 'Tax Amount', 'Subtotal')
                ocr_line = ocr_text.split('\n')
                
                for item in range(len(ocr_line)):
                    if ocr_line[item].count('|') == 1:
                        ocr_line[item] = ocr_line[item].replace(' G ', ' | G ')
                    quantity = ocr_line[item].split('|')[0].strip()
                    item_no = ocr_line[item].split('|')[1].strip().split(' ')[0]
                    description = ocr_line[item].split('|')[1].replace(item_no, '').strip()
                    unit_price = description.split(' ')[-1]
                    description = description.replace(unit_price, '').strip()
                    total_price = ocr_line[item].split('|')[-1].split(' ')[-1]
                    r.type('#quantity_row_' + str(item + 1), quantity)
                    r.type('#description_row_' + str(item + 1), description)
                    r.type('#price_row_' + str(item + 1), total_price.replace(',', ''))
                    if item != len(ocr_line) - 1:
                        r.click('//button')

                r.click('#fileupload')
                r.wait(1.25)
                # png need only primary monitor not plug in to a secondary monitor
                # lookang dont think i need this, my mac opens list view is big, more than 8 items
                #if 'Invoice10' in filename: r.click('show_all2.png')
                r.keyboard(filename.replace('.tiff.txt', '') + '[enter]')
                r.click('#agreeToTermsYes')
                r.click('#submit_button')

            else:
                print('[ERROR][' + filename.replace('.txt','') + '] unrecognised invoice format')
# r.wait(10) # too long, didnt snap timing
r.wait(5)
r.snap('page', 'week4results.png')
r.close()