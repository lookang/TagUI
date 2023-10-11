
//pdftext = [/Users/lookang/Desktop/tagui/flows/addSyllabus/9744_y22_sy.pdf]
//echo `pdftext`
//dump [`pdftext`] to text.csv


// Navigate to the SLS login page
https://vle.learning.moe.edu.sg/login
wait 3

//live

ask 1 for SLS 2 for MIMS login
echo `ask_result`
if ask_result equals to 1
	// Click the "Login With SLS" button if present
	if present('//button[normalize-space()="Login With SLS"]')
		click //button[normalize-space()='Login With SLS']
	// Click the "Login" button if present
	if present("//button[normalize-space()='Login']")
		click //button[normalize-space()='Login']
else if ask_result equals to 2
	// Click the "Login With MIMS" button if present
	if present("//button[normalize-space()='Login With MIMS']")
		click //button[normalize-space()='Login With MIMS']
		wait 3
		click (//span[@id='loginButton2'])[1]

//else 
//do ntg to skip live
//	echo "do ntg"
//live
//crawl syllabus from any course edit here
// https://vle.learning.moe.edu.sg/mrv/class-group/lesson/view/fca2f866-1a59-4404-af5b-cd42a0d2661b/cover
https://vle.learning.moe.edu.sg/class-group/lesson/edit/1aff6f7f-5deb-41e3-8389-afc856c5a1fb/page/46993472
live
click Kebab24
click Pencil24
click Pencil16
click (//span[@class='title'])[4]

echo get into the syllabus page
for i from 1 to 300
	if present ('(//span[@class="tree-anchor"])[`i`]')
		// not optimised, clicking every element in tree to exand the view
		click (//span[@class='tree-anchor'])[`i`]
	else
		break

for j from 1 to 300
	if present ('(//div[@class="paragraph"])[`j`]')
		read (//div[@class='paragraph'])[`j`] to text
		echo `text`
		write `csv_row([j, text ])` to h2physics.csv
//live


