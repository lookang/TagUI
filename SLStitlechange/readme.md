# SLStitlechange

This repository contains the source code for the SLStitlechange project. 

## Description

SLStitlechange is a project that uses TagUI, an open-source and leading RPA software, to automate tasks. The main goal of this project is to automate the process of changing titles in SLS (Student Learning Space). 

## Installation

1. Clone this repository to your local machine using `https://github.com/lookang/TagUI.git`.
2. Navigate to the `SLStitlechange` directory.
3. Install the necessary dependencies.

## Usage

To use this project, follow these steps:

1. Open your terminal.
2. Navigate to the `SLStitlechange` directory.
3. Run the script.

It seems like you're trying to run a TagUI script from the command line. Here's how you can do it:

1. Open your terminal.
2. Navigate to the directory where your `titlechangefromurl.tag` file is located.
3. Run the following command: `tagui titlechangefromurl.tag url.csv`

Please ensure that your `url.csv` file is in the correct format. It should look something like this:

```
p1	p2	p3
Forces and Their Effects [LSS]		https://vle.learning.moe.edu.sg/moe-library/lesson/view/341e6734-7c71-40f6-9a1e-e6ba8dc97fdf/cover
Friction [LSS]		https://vle.learning.moe.edu.sg/mrv/moe-library/lesson/view/429087ea-4034-4f4e-8ceb-2f6934169760/cover
Simple Machines [LSS]		https://vle.learning.moe.edu.sg/mrv/moe-library/lesson/view/fcf7150b-39b4-422f-a763-a5de1c950cb6/cover
```

The third column (`p3`) is used with the variable name `p3` in the code.

**Note:** TagUI requires a CSV file to run, so if you have an Excel file, you'll need to export it to CSV format first. If you have any other questions or need further clarification, feel free to ask! 😊
Please note that you may need to adjust the script according to your specific needs.

## Contributing

Contributions are welcome! Please read the contributing guidelines before getting started.

## License

This project is licensed under the terms of the MIT license.

## Contact

If you have any questions, feel free to reach out or open an issue.

**Note:** This README is a general guide and may not cover all aspects of the project. For more specific information, please refer to the project's documentation or contact the project maintainer.
