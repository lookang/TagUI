# SLS Keywords Remover and Adder

This repository contains a TagUI script, `keywordaddtoallquestionsintelligent2.tag`, which is designed to automate the process of adding keywords to all questions in the Singapore Learning Space (SLS) platform.

## Video Explainer
https://www.youtube.com/watch?v=9arM1WnHlx8 

## How it works

The script navigates to the SLS login page and logs in using either the SLS or MIMS login, depending on the user's choice. It then iterates over a list of URLs in the url.csv file, each representing a different lesson on the SLS platform. For each lesson, it navigates to the lesson page, enters edit mode, and adds keywords to all activities within the lesson. to remove keywords, type inside the url.csv file under the p4 to p11 columns. To add new keywords, add in the add1 and add2 columns.

## Prerequisites

To run this script, you need to have TagUI installed on your machine. You can download it from [here](https://github.com/kelaberetiv/TagUI).

## Usage

1. Prepare your data in a .csv file. The script expects a .csv file where each row represents a different lesson. The third column should contain the URL of the lesson.

2. Run the script from the command line with the following command:

```bash
tagui keywordaddtoallquestionsintelligent2.tag url.csv
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
