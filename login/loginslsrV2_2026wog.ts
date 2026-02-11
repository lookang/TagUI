import { test, expect, Page } from '@playwright/test';
import * as fs from 'fs';
import * as path from 'path';

// Helper function to parse CSV (similar to the TagUI one)
function CSVToArray(strData: string, strDelimiter: string = ","): string[][] {
    const objPattern = new RegExp(
        (
            "(\\" + strDelimiter + "|\\r?\\n|\\r|^)" +
            "(?:\"([^\"]*(?:\"\"[^\"]*)*)\"|" +
            "([^\"\\" + strDelimiter + "\\r\\n]*))"
        ),
        "gi"
    );
    const arrData: string[][] = [[]];
    let arrMatches = null;
    while (arrMatches = objPattern.exec(strData)) {
        const strMatchedDelimiter = arrMatches[1];
        if (strMatchedDelimiter.length && strMatchedDelimiter !== strDelimiter) {
            arrData.push([]);
        }
        let strMatchedValue: string;
        if (arrMatches[2]) {
            strMatchedValue = arrMatches[2].replace(new RegExp("\"\"", "g"), "\"");
        } else {
            strMatchedValue = arrMatches[3];
        }
        arrData[arrData.length - 1].push(strMatchedValue);
    }
    return arrData;
}

function formatDate(date: Date): string {
    return `${date.getDate()}/${date.getMonth() + 1}/${date.getFullYear()}`;
}

function containsSubstring(str: string, sub_str: string): boolean {
    return str.toLowerCase().includes(sub_str.toLowerCase());
}

test('SLS Community Gallery Review Extraction', async ({ page }) => {
    test.setTimeout(0); // Disable timeout for manual login

    // 1. Login Phase
    console.log('Navigating to SLS Login...');
    await page.goto('https://vle.learning.moe.edu.sg/login');
    console.log('Please login yourself to overcome slow WOG. Waiting for navigation to community gallery...');
    
    // We wait for the user to login and navigate to the admin page or just pause
    // In TagUI it used "live", here we can wait for a specific URL or use pause
    await page.pause(); 

    const galleryUrl = 'https://vle.learning.moe.edu.sg/admin/community-gallery?keyword=&location=COMMUNITY_GALLERY&resource=LESSON&status=PENDING_APPROVAL';
    await page.goto(galleryUrl);
    await page.waitForTimeout(5000);

    // Handle WalkMe if present
    const walkMeCancel = page.locator('.walkme-custom-balloon-cancel-button, .walkme-action-cancel');
    if (await walkMeCancel.isVisible()) {
        await walkMeCancel.click();
    }

    // Sort by Date Submitted (Twice to get oldest first/bottom as per TagUI)
    const dateSubmittedHeader = page.locator('.v-data-table-header__content', { hasText: 'Date Submitted' });
    await dateSubmittedHeader.click();
    await page.waitForTimeout(1000);
    await dateSubmittedHeader.click();
    await page.waitForTimeout(1000);

    // Get total number of lessons
    const paginationInfo = page.locator('.v-data-table-footer__info');
    let total = 0;
    if (await paginationInfo.isVisible()) {
        const text = await paginationInfo.innerText();
        const parts = text.split('of');
        if (parts.length > 1) {
            total = parseInt(parts[1].trim());
        }
    }
    
    console.log(`There are ${total} number of lessons.`);
    if (total === 0) {
        console.log('No lessons to review! Hurray');
        return;
    }

    // Interactive step: ask user to check
    console.log('Review the list. Type "done" in console when ready to continue extraction.');
    // Note: Playwright doesn't have a direct "ask" like TagUI. We will proceed or wait for a key.
    // For automation we'll just wait for user to be ready.
    await page.pause();

    const startChoice = "0"; // Defaulting to 0 for extraction
    let rowCnt = startChoice === '0' ? 1 : Math.floor(parseInt(startChoice));
    let tableCnt = 0;

    const pending: any[] = [];
    const rows = page.locator('table tbody tr');

    for (let i = 1; i <= (total - tableCnt * 20); i++) {
        // Construct the row selector
        const row = rows.nth(rowCnt - 1);
        if (!(await row.isVisible())) break;

        const title = await row.locator('td').nth(0).innerText();
        const type = await row.locator('td').nth(1).innerText();
        const subject = await row.locator('td').nth(2).innerText();
        const level = await row.locator('td').nth(3).innerText();
        const school = await row.locator('td').nth(4).innerText();
        const dateSubmitted = await row.locator('td').nth(7).locator('span').first().innerText();
        let author = await row.locator('td').nth(7).locator('span').nth(1).innerText();
        
        if (author.startsWith('By ')) author = author.slice(3);

        let similar = 0;
        const similarIcon = row.locator('td').nth(0).locator('button span');
        if (await similarIcon.isVisible()) {
            const tooltip = await similarIcon.innerText();
            if (tooltip.includes('similar to another resource')) {
                similar = 1;
            }
        }

        let resubmit = 0;
        const resubmitLabel = row.locator('td').nth(0).locator('.v-chip__content'); // Adjust based on actual UI
        if (await resubmitLabel.isVisible()) {
            const text = await resubmitLabel.innerText();
            if (text === 'Resubmitted') resubmit = 1;
        }

        let link = "";
        if (similar === 0) {
            const openLink = row.locator('td').nth(0).locator('a');
            if (await openLink.isVisible()) {
                console.log('trying to click OPEN');
                try {
                    const [newPage] = await Promise.all([
                        page.context().waitForEvent('page', { timeout: 15000 }),
                        openLink.click(),
                    ]);
                    await newPage.waitForLoadState();
                    link = newPage.url();
                    console.log(`managed to click on the link OPEN: ${link}`);
                    await newPage.close();
                } catch (e) {
                    console.log('OPEN link did not open a new page or timed out');
                }
            }
        }

        pending.push([i, title, type, subject, level, school, dateSubmitted, author, link, similar, resubmit]);
        console.log(`Extracted: ${title}`);

        rowCnt++;
        if (rowCnt === 21 && (total % 20 !== 0)) {
            const nextButton = page.getByRole('button', { name: 'Next page' });
            if (await nextButton.isEnabled()) {
                await nextButton.click();
                tableCnt++;
                rowCnt = 1;
                await page.waitForTimeout(2000);
            }
        }
    }

    // Reviewer Assignment Logic
    const adminCsvPath = path.join(__dirname, '2024 CG Admin Subjects and Emails - CG Admin emails.csv');
    const adminTableRaw = fs.readFileSync(adminCsvPath, 'utf8');
    const adminInfo = CSVToArray(adminTableRaw);

    const subjectToName: any = {};
    const nameToEmail: any = {};
    const numReviewed: any = {};

    for (let i = 1; i < adminInfo.length; i++) {
        const row = adminInfo[i];
        if (row.length < 11) continue;
        const name = row[1]?.trim();
        const email = row[8]?.trim();
        const subjects = [row[3]?.trim().toLowerCase(), row[4]?.trim().toLowerCase()];
        let level = row[2]?.trim().toLowerCase();
        const reviewed = row[9]?.trim() === '' ? 0 : parseInt(row[9]);
        const active = row[10]?.trim();

        if (!email || active === '0') continue;

        numReviewed[name] = reviewed;
        nameToEmail[name] = email;

        if (!level) level = "pri";
        if (!(level in subjectToName)) subjectToName[level] = {};

        for (let sub of subjects) {
            if (!sub) break;
            if (containsSubstring(sub, 'chinese')) sub = 'chinese';
            if (!(sub in subjectToName[level])) subjectToName[level][sub] = [];
            subjectToName[level][sub].push(name);
        }
    }

    let dateOffset = 5;
    let dueDate = new Date();
    let curDate = new Date();
    while (dateOffset) {
        dueDate.setDate(dueDate.getDate() + 1);
        if (dueDate.getDay() !== 0 && dueDate.getDay() !== 6) {
            dateOffset--;
        }
    }

    let cmdMsg = '\n---------PLEASE REVIEW THE FOLLOWING MESSAGES---------\n';
    const latest: any = {};

    for (let i = 0; i < pending.length; i++) {
        const row = pending[i];
        const sn = row[0];
        let subject = row[3].trim().toLowerCase();
        const author = row[7].trim().toLowerCase();
        const title = row[1].trim().toLowerCase();
        const similar = row[9];
        
        let level = row[4].trim().toLowerCase();
        const origLevel = level;
        if (containsSubstring(level, "sec")) level = "sec";
        else if (containsSubstring(level, "jc") || containsSubstring(level, "college") || containsSubstring(level, "pre-u")) level = "jc";
        else level = "pri";

        let adminAssigned = false;
        let recipientName = '';
        let duplicate = 0;
        let similarTo = '';

        if (similar === 1) {
            for (let k = 0; k < i; k++) {
                if (pending[k][1].trim().toLowerCase() === title && pending[k][7].trim().toLowerCase() === author) {
                    duplicate = 1;
                    cmdMsg += `ALERT: Item ${sn} is detected as duplicate.\n`;
                    break;
                }
            }
            if (duplicate === 0) {
                if (!(author in latest)) {
                    cmdMsg += `ERROR: Item ${sn} marked "similar" but source not found.\n`;
                } else {
                    const similarIdx = latest[author];
                    similarTo = pending[similarIdx - 1][1];
                    recipientName = pending[similarIdx - 1][11];
                    if (recipientName) {
                        numReviewed[recipientName]++;
                        adminAssigned = true;
                    }
                }
            }
        } else {
            latest[author] = sn;
            let attemptCounter = 1;
            let subjectFound = subjectToName[level]?.hasOwnProperty(subject);
            
            while (!subjectFound) {
                for (const sub in subjectToName[level]) {
                    if (sub === 'd&t' && containsSubstring(subject, "design & technology")) {
                        subject = 'd&t'; subjectFound = true;
                    } else if (sub === 'pe' && containsSubstring(subject, "physical education")) {
                        subject = 'pe'; subjectFound = true;
                    } else if (containsSubstring(subject, sub) || containsSubstring(sub, subject)) {
                        subject = sub; subjectFound = true;
                    }
                    if (subjectFound) break;
                }
                if (subjectFound || attemptCounter >= 3) break;
                level = level === "pri" ? "sec" : (level === "sec" ? "jc" : "pri");
                attemptCounter++;
            }

            if (!subjectFound) {
                cmdMsg += `ERROR: Item ${sn}: Cannot find subject "${subject}".\n`;
            } else {
                if (attemptCounter > 1) {
                    cmdMsg += `ALERT: Item ${sn}: Subject "${subject}" found at "${level}" instead of "${origLevel}".\n`;
                }
                subjectToName[level][subject].sort((a: string, b: string) => numReviewed[a] - numReviewed[b]);
                recipientName = subjectToName[level][subject][0];
                numReviewed[recipientName]++;
                adminAssigned = true;
            }
        }

        if (!adminAssigned) {
            pending[i] = [...pending[i], '', '', '', duplicate, similarTo, ''];
        } else {
            pending[i] = [...pending[i], recipientName, formatDate(curDate), formatDate(dueDate), duplicate, similarTo, nameToEmail[recipientName]];
        }
    }

    // Output results
    const outputPath = path.join(__dirname, 'pendingreview_list.csv');
    const header = ["S/N", "Title", "Type", "Subject", "Level", "School", "Date Submitted", "Author", "URL", "Similar", "Resubmitted", "Assigned To", "Date Lesson Assigned", "Due Date", "Duplicate", "Similar To", "Email of Admin"];
    const csvLines = [header.join(',')];
    
    for (const p of pending) {
        csvLines.push(p.map((val: any) => `"${val}"`).join(','));
    }
    fs.writeFileSync(outputPath, csvLines.join('\n'));
    console.log(cmdMsg);
});
