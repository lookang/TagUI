# SLS Keywords Remover and Adder

This repository contains a TagUI script, `keywordaddtoallquestionsintelligent2.tag`, which is designed to automate the process of adding keywords to all questions in the Singapore Learning Space (SLS) platform.

## Video Explainer
https://www.youtube.com/watch?v=9arM1WnHlx8 

## How it works

The script navigates to the SLS login page and logs in using either the SLS or MIMS login, depending on the user's choice. It then iterates over a list of URLs, each representing a different lesson on the SLS platform. For each lesson, it navigates to the lesson page, enters edit mode, and adds keywords to all activities within the lesson.

## Prerequisites

To run this script, you need to have TagUI installed on your machine. You can download it from [here](https://github.com/kelaberetiv/TagUI).

## Usage

1. Prepare your data in a .csv file. The script expects a .csv file where each row represents a different lesson. The third column should contain the URL of the lesson.

2. Run the script from the command line with the following command:

```bash
tagui keywordaddtoallquestionsintelligent.tag url.csv
```

Replace `url.csv` with the path to your .csv file.

## Limitations

Please note that there is a limit to the number of keywords that can be added to each activity. If this limit is exceeded, an error may occur.

## Contributing

Contributions are welcome! Please feel free to submit a pull request or open an issue if you have any improvements or suggestions.

## License

This project is licensed under the MIT License.
