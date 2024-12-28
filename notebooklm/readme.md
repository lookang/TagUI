# TagUI Script: Automating Page Analysis and Logging

This repository contains a **TagUI automation script** designed to analyze pages on the `https://sg.iwant2study.org` website. The script identifies specific types of articles and performs various automated actions, such as generating summaries, creating notes in NotebookLM, and logging valid pages for further processing.

## Features

- **Page Navigation**: Iterates through a range of pages on the target website.
- **Content Analysis**: Checks for specific keywords in the page title and content:
  - **404 Article not found**
  - Articles related to:
    - PhET
    - GeoGebra
    - Molecular Workbench
  - Unpublished articles
- **NotebookLM Integration**: Automatically creates a new website entry and generates:
  - Audio
  - Briefing documents
  - Study notes
  - FAQs
- **Robust Case-Insensitive Matching**: Handles variations in capitalization.
- **Error Handling**: Skips pages with errors or invalid content gracefully.

## Prerequisites

1. **TagUI**: Install [TagUI](https://github.com/kelaberetiv/TagUI).
2. **Supported Browser**: Ensure Chrome, Edge, or Firefox is installed and configured for TagUI.
3. **NotebookLM Account**: Access to [NotebookLM](https://notebooklm.google.com).

## Usage

1. Clone this repository:
   ```bash
   git clone https://github.com/<your-username>/<repo-name>.git
   cd <repo-name>

