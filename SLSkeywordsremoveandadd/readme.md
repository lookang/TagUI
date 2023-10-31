# SLS Keywords Remover and Adder in 2 languages TagUI and TagUI-Python

This repository contains a TagUI script, `keywordaddtoallquestionsintelligent2.tag`, which is designed to automate the process of removing as well as adding keywords to all questions in the Singapore Learning Space (SLS) platform.
Newly added, a TagUI-Python script, `keywordaddtoallquestionsintelligent2.py` which is designed to automate the process of removing as well as adding keywords to all questions in the Singapore Learning Space (SLS) platform, but using python.


## Video Explainer
https://www.youtube.com/watch?v=9arM1WnHlx8 

## How it works

The script navigates to the SLS login page and logs in using either the SLS or MIMS login, depending on the user's choice. It then iterates over a list of URLs in the url.csv file, each representing a different lesson on the SLS platform. For each lesson, it navigates to the lesson page, enters edit mode, and removes and  adds keywords to all activities within the lesson. 
- For columns p4 to p7, apply element.toLowerCase() to capture various string variations such as "NT Sci," "nt sci," "NT SCI," "nt SCI," and so on.
- In columns p8 to p9, use the "contains" rule. This means that any entry, for instance, "G1 sci," will be removed as long as it contains the specified keyword, like "G1 science."
- In columns p10 to p11, use the "equals to" rule. This requires an exact match for removal. For instance, only "nts" will be removed.
- To add new keywords, add in the add1 and add2 columns.

## Prerequisites

To run this script, you need to have TagUI installed on your machine. You can download it from [here](https://github.com/kelaberetiv/TagUI).

for Python, check to install the correct Python-TagUI library, please check the repository https://github.com/tebelorg/RPA-Python for installation steps.

## Usage

1. Prepare your data in a .csv file. The script expects a .csv file where each row represents a different lesson. The third column should contain the URL of the lesson. columns p4 to p11 contains keywords to remove, empty them if there is nothing to change for p8 to p11 for example. Edit add1 and add2 for keywords to add. 

2. Run the script from the command line with the following command:

```bash
tagui keywordaddtoallquestionsintelligent2.tag url.csv
```
```bash
python keywordaddtoallquestionsintelligent2.py
```

Replace `url.csv` with the path to your .csv file.

## Limitations

// Please note the following limitations:
- The keyword limit could be exhausted, causing an error.
- A screen saver can interrupt the flow of the script. If necessary, set your screen saver to 'Never'.
- While the script is running, it needs control of the keyboard and screen. Therefore, it's not advisable to multitask.
- Sometimes SLS will pop up on the left bottom corner "rate your experience...", just close it manually to prevent it from disturbing the flow

## Contributing

Contributions are welcome! Please feel free to submit a pull request or open an issue if you have any improvements or suggestions.

## License

This project is licensed under the CC_BY_SA
