
# Physics Lesson Content Map Tagging Automation

## Usage

To run the script, use the following command:

```
tagui PhysicsLessonContentMapTag.tag crawldatabase.csv
```

## Script Overview

This TagUI script automates the process of logging into the SLS (Singapore Learning Space) portal and adding content map tags to physics lesson pages.

### Steps

1. **Echoing Variables**: 
   - Prints the values of variables `i`, `title`, `link`, and `status`.

2. **Iteration Handling**:
   - If it's the first iteration, the script navigates to the SLS login page and prompts the user to choose between SLS or MIMS login.
   - Logs in based on the user's choice.

3. **Visit URLs**:
   - Extracts the URL substring from the link and constructs the editable URL.
   - Visits the editable URL.

4. **Adding Content Map Tags**:
   - Clicks on the "Unpublish" button and confirms.
   - Opens the lesson page in a popup window.
   - Clicks to edit the lesson.
   - Adds a new lesson tag.
   - Determines the number of existing lesson tags.
   - Calculates the start number for new tags.
   - Selects the subject and level for the lesson.
   - Stops for human intervention if needed.
   - Saves the changes and closes the popup window.

## Prerequisites

- TagUI installed: Refer to the official TagUI documentation for installation instructions: [TagUI Setup](https://tagui.readthedocs.io/en/latest/setup.html)
- Basic understanding of TagUI scripting syntax.

---
