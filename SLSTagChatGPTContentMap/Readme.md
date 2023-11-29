# SLSTagChatGPTContentMap

This repository contains the `tagContentMapChatGPT.tag` file for the TagUI project.

## Description

The `tagContentMapChatGPT.tag` file is a part of the TagUI project. This file is used to automate the process of adding content maps learning objectives to questions in the Singapore Learning Space (SLS) platform. It works best on a computer that 
- auto-fills passwords to SLS and may need some configuration for manual key-in password machines.
- auto-login to https://chat.openai.com/ and has the chatGPT already with pre-training data, copied by human currently. Also need to rename the tab for each content map so that different dataset is used for hopefully better results.

## YouTube

[![Everything Is AWESOME](https://i.stack.imgur.com/q3ceS.png)](https://youtu.be/StTqXEQ2l-Y?t=35s "Everything Is AWESOME")

## Role of Human
prepare the data.csv
prepare the content map csv by running another TagUI to get the CSV out https://github.com/lookang/TagUI/tree/main/crawlSyllabusFromContentMap
prepare the https://chat.openai.com/ dataset to 'train' which is the csv file of the content map and the prompt engineering 
improve the script
may need to edit some parts of the code to achieve other results and objectives

## Installation

1. Clone this repository.
2. Install TagUI.

## Usage

1. Define parameters in `data.csv`.
2. Run the command `tagui tagSemiContentMapChatGPT.tag data.csv` in the command line.

## Parameters

- `partofURL`: Part of the URL that forms the id of the lesson.
- `contentMapOrder`: Order of the content syllabus to add.
- `level`: Level of content map.
- `subject`: Subject.
- `URLofQuiz`: The URL id of the progressive quiz page.

## Contributing

If you wish to contribute to this project, please follow these steps:
1. Fork the repository.
2. Create a new branch.
3. Make your changes and commit them.
4. Push your changes to your fork.
5. Open a pull request.

## License

This project is licensed under the MIT License.

## Contact

If you have any questions, feel free to reach out.

