
# Automated SLS Resource Management Delete Draft and Unpublished Script

This script automates logging into the SLS (Singapore Learning Space) platform, navigating to specific resources, and performing actions like deleting rejected lessons. The script is written for streamlined handling of draft or rejected lesson resources and assumes use of a browser automation tool like TagUI.

## Features
1. **Automated Login**:
   - Navigates to the SLS login page and performs login with user-provided credentials.
2. **Resource Filtering**:
   - Directly navigates to filtered pages for specific subjects and resource statuses (e.g., `DRAFT`, `REJECTED`).
3. **Bulk Actions**:
   - Iterates over a defined number of resource entries (default: 20) to perform actions such as opening and deleting resources.

## Prerequisites
- Install and configure [TagUI](https://tagui.readthedocs.io/en/latest/).
- Ensure credentials are updated in the script for SLS access.

## Usage

### Step 1: Configure Script
1. Replace placeholders in the script:
   - `MOE-XXXXXX` with your SLS username.
   - `PASSWORD` with your SLS password.
2. Adjust the URL for `manage-resource` to include desired filters for subjects, owner groups, and statuses.

### Step 2: Run the Script
Run the script using the TagUI command-line interface:

tagui your-script-filename.tag
### Step 3: Monitor Actions
The script performs actions iteratively over the specified number of resources (end = 20).
To handle more resources, restart the script after the first batch completes.
Script Workflow
Navigate to the SLS login page: https://vle.learning.moe.edu.sg/login.
Log in using provided credentials.
Navigate to the filtered resources page:
Example: Filter rejected lessons for a specific subject.
Iterate through resources and perform the desired action:
Open each resource.
Delete the resource if conditions are met.
### Video Demonstration
For a step-by-step visual guide, watch the video tutorial:
## Video Demonstration
For a step-by-step visual guide, watch the video tutorial:  
[![Watch Video](https://img.youtube.com/vi/qGPfyC2dxHc/0.jpg)](https://www.youtube.com/watch?v=qGPfyC2dxHc)


### Limitations
The script is currently hardcoded to handle only the first 20 items in the filtered results. To process additional pages, restart the script manually.
Ensure proper error handling and fallback mechanisms to avoid unintended deletions.
License
This script is provided as-is for educational and personal use. Use at your own risk, and ensure compliance with your organization's data and automation policies.
