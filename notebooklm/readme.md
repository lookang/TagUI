Here’s an improved version of the `README.md` file for your `notebooklm` directory on the `TagUI` GitHub repository:

---

# TagUI Automation Script for NotebookLM Integration

This repository contains a **TagUI automation script** designed to analyze and process pages from the [iwant2study.org](https://sg.iwant2study.org) website. The script integrates with [NotebookLM](https://notebooklm.google.com) to automate the creation of notes, audio, and other resources for specific types of articles.

## Features

### 1. **Page Analysis**
- Iterates through a range of pages (`start` to `300`) on the target website.
- Identifies content based on:
  - **PhET** simulations
  - **GeoGebra** models
  - **Molecular Workbench** articles
  - Unpublished articles or 404 errors

### 2. **NotebookLM Automation**
- Automatically creates entries in NotebookLM for valid articles.
- Generates:
  - Audio summaries
  - Briefing documents
  - Study notes
  - FAQs

### 3. **Robust Matching**
- Case-insensitive keyword matching ensures reliable identification of articles.

### 4. **Error Handling**
- Skips invalid or 404 pages without stopping the script.

## Prerequisites

### Install TagUI
Ensure [TagUI](https://github.com/kelaberetiv/TagUI) is installed and correctly configured.

### Set Up Browser Automation
TagUI requires a supported browser (Chrome, Edge, or Firefox). Make sure your browser is ready for automation.

### NotebookLM Account
Sign in to [NotebookLM](https://notebooklm.google.com) with your Google account to enable automated note creation.

## Usage

### Clone the Repository
```bash
git clone https://github.com/lookang/TagUI.git
cd TagUI/notebooklm
```

### Run the Script
```bash
tagui note.tag
```

### Monitor Progress
The script logs progress to the console, showing page numbers, titles, and actions taken.

### Customize the Script
1. Open `note.tag` in a text editor.
2. Modify the `start` variable to change the starting page number.
3. Add or update keyword matching in the `else if` conditions for new content types.

## Script Workflow

1. **Page Navigation**:
   - The script navigates to each page in the specified range.
2. **Content Analysis**:
   - Titles and content are scanned for specific keywords.
3. **NotebookLM Integration**:
   - Valid articles are logged in NotebookLM with associated resources.
4. **Error Handling**:
   - Skips invalid or unpublished pages.

## Example Output

```plaintext
counter is 1
https://sg.iwant2study.org/ospsg/index.php/265
page_title is "Hooke's Law Model by PhET"
found Phet Article going to next page
page is 265
...
```

## Customization Options

### Adjust Page Range
Modify the loop in `note.tag` to process a different range of pages:
```javascript
for page = start to 500  // Example: process pages up to 500
```

### Add New Content Checks
Update the `else if` conditions to detect additional keywords or content types:
```javascript
else if page_title_lower contains "newkeyword"
    echo found New Keyword Article, going to next page
    // Add any specific actions for this type
```

### Modify NotebookLM Actions
Change the XPath selectors or actions to align with updates to the NotebookLM interface.

## Known Issues

1. **Browser Compatibility**:
   - Ensure the browser used is supported by TagUI.
2. **Dynamic Website Changes**:
   - If the structure of `iwant2study.org` changes, update XPath selectors in the script.
3. **NotebookLM Interface Updates**:
   - Adjust the script if Google updates the NotebookLM interface.

## Contributing

Contributions are welcome! To contribute:
1. Fork the repository.
2. Create a feature branch:
   ```bash
   git checkout -b feature/your-feature-name
   ```
3. Commit your changes:
   ```bash
   git commit -m "Add your feature description"
   ```
4. Push your branch and open a pull request.

## License

This project is licensed under the [MIT License](LICENSE).

## Author

**Lookang**  
[GitHub Profile](https://github.com/lookang)

---

Feel free to update this `README.md` with additional details, screenshots, or specific configurations based on your latest changes.
