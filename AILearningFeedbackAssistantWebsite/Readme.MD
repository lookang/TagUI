# Language Feedback Assistant Website Crawler

A script that crawls a website and extracts feedback on language errors from the website https://dev2.literatu.com/api-test-moe.html.

## Project description

This project is a TagUI script that automates the process of testing the Language Feedback Assistant (LFA) website. The LFA website is a tool that provides feedback on language errors in written texts. The script takes an Excel file as input for sentence, which contains sentences with language errors. The script then types each sentence into the LFA website, clicks the submit button, and waits for the feedback. The script then reads the feedback and writes it to a CSV file, along with the sentence number and the original sentence. The script also handles cases where there are multiple errors, no errors, or different types of errors in the same sentence.

## Installation

To run this script, you need to have TagUI installed on your machine. TagUI is a free and open-source tool that lets you automate web interactions using simple commands. You can download TagUI from [here](https://tagui.readthedocs.io/en/latest/setup.html) and follow the installation instructions for your operating system.

## Usage

To use this script, you need to have an Excel file that contains sentences with language errors. The Excel file should have two columns: A and B. Column A should have the sentence number, and column B should have the sentence. The Excel file should be named "database.xlsx" and placed in the same folder as the script. Alternatively, you can change the file name and path in the script.

To run the script, open a terminal or command prompt and navigate to the folder where the script is located. Then type the following command:


tagui lfacrawlwebsite1.tag -t


This will launch the script in test mode in turbo, which means it will show the web browser and the steps it is performing in super fast typing. 

The script will create a CSV file named "dataLFAwebsite1.csv" in the same folder as the script. The CSV file will have four columns: Number, Sentence, issueText, and errant Codes. Number is the sentence number from the Excel file or loop, Sentence is the original sentence, issueText is the feedback text from the LFA website, and errant Codes are the error codes from the LFA website.

## Contributing

This project is open for contributions. If you find any bugs, errors, or improvements, please feel free to report them as issues or submit pull requests.

## License

This project is licensed under the MIT License. See the [LICENSE](https://github.com/tchapi/markdown-cheatsheet/blob/master/README.md) file for details.
