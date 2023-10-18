The GitHub repository you mentioned contains a collection of TagUI samples created to increase productivity 1. The fullscreen.tag script is one of the samples in the repository. It is a TagUI automation script that opens a web page in full-screen mode 1.

The script starts by opening the URL of the web page to be displayed in full-screen mode 1. It then waits for the page to load completely before maximizing the window to full-screen mode 1. Finally, it saves a screenshot of the full-screen window as a PNG file 1.

Here is the code for fullscreen.tag:

// open web page
chrome https://www.bing.com

// wait for page to load
wait 5

// maximize window to full screen
keyboard F11

// save screenshot of full screen
snap full_screen.png
