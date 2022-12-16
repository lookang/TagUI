
//pdftext = [/Users/lookang/Desktop/tagui/flows/addSyllabus/9744_y22_sy.pdf]
//echo `pdftext`
//dump [`pdftext`] to text.csv

//if iteration equals to 1
//echo login yourself to SLS
//live
https://vle.learning.moe.edu.sg/login
click Login with MIMS
wait 2
click Sign in
wait 5
//else 
//do ntg to skip live
//	echo "do ntg"
//live
//crawl syllabus from any course edit here
// h1 physics
//https://vle.learning.moe.edu.sg/mrv/class-group/lesson/view/fca2f866-1a59-4404-af5b-cd42a0d2661b/cover
https://vle.learning.moe.edu.sg/mrv/class-group/lesson/view/f0dde450-d851-4e4a-ab3f-427c2bbafedd/cover
//live
wait 2
// 3 dots top right corner
click Kebab24
// edit
click Pencil24
//edit 
click Pencil16
//title
live
click (//span[@class='title'])[4]

echo get into the syllabus page
for i from 1 to 300
	if present ('(//span[@class="tree-anchor"])[`i`]')
		// not optimised, clicking every element in tree to exand the view
		click (//span[@class='tree-anchor'])[`i`]
		read (//span[@class='tree-anchor'])[`i`] to temp
		echo `temp`
	else
		break

for j from 1 to 300
	if present ('(//div[@class="paragraph"])[`j`]')
		read (//div[@class='paragraph'])[`j`] to text
		echo `j` is `text`
		write `csv_row([j, text ])` to h2physics.csv
//live


