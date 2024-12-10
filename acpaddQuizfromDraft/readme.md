# ReadMe for Automating Module Management in VLE especially to add A Quiz of 5 MCQ and 2 short answers using Authoring Co-Pliot 

This script automates interaction with the **Virtual Learning Environment (VLE)** at `https://vle.learning.moe.edu.sg/`. The automation involves logging in, navigating to specific modules, extracting information, and processing modules efficiently.

---
Example Video: YouTube Link https://www.youtube.com/watch?v=xMvQe0kp068&t=8s

## **Prerequisites**
1. **Environment Setup**: 
   - Ensure you have an RPA tool like **TagUI** installed and configured.
2. **User Permissions**: 
   - Ensure your account has access to the relevant modules and resources.
3. **Dependencies**: 
   - Any required browser extensions or drivers (e.g., for Chrome) must be pre-installed.

---

## **Features of the Script**
### **1. Automated Login**
- Automatically logs in using the "Login With SLS" button.
- Waits appropriately to ensure the login flow is completed.

### **2. Navigate to Resource Management**
- Accesses the URL to manage draft or unpublished lesson resources filtered by subjects.

### **3. Process Modules**
- Loops through modules (from index 15 to 20) and performs the following:
  - Opens a specific module from the list.
  - Extracts and copies text or worksheet content to a clipboard.
  - Modifies module content, such as adding quizzes or enabling learning progress tracking.
  - Approves the module after processing.

### **4. Knowledge Base Handling**
- Extracts print-friendly versions of content and integrates knowledge base content into modules.

### **5. Quiz Creation**
- Adds a new quiz with:
  - 5 multiple-choice questions (MCQs).
  - 2 short-answer questions.
- Sets quiz attributes like inclusion in learning progress.

### **6. Learning Progress Inclusion**
- Ensures questions are included in the learning progress tracking system.

### **7. Approval and Finalization**
- Approves processed modules and confirms successful changes.

---

## **Usage Instructions**

1. **Login to VLE**
   - Navigate to `https://vle.learning.moe.edu.sg/login`.
   - Ensure your login credentials are correct.

2. **Run the Script**
   - Update the module indices (`start` and `end`) in the script as per the range of modules you wish to process.
   - Execute the script in your RPA tool.

3. **Module Navigation and Processing**
   - The script automatically navigates to each module and performs the required actions:
     - Opens the module.
     - Extracts and integrates content.
     - Configures quizzes and learning progress settings.
     - Approves and closes the module.

4. **Verify Results**
   - After the script completes, manually verify that the modules were processed correctly.

---

## **Key Elements in the Script**

| **Functionality**           | **XPath/Selector Used**                              | **Description**                                                                 |
|------------------------------|-----------------------------------------------------|---------------------------------------------------------------------------------|
| **Login**                   | `//button[normalize-space()='Login With SLS']`      | Clicks the "Login With SLS" button to initiate login.                          |
| **Open Module**             | `//*[@id="main-content"]/div/.../tr[n]/td[1]/div/a` | Opens a module by its index in the table.                                      |
| **Extract Content**         | `View as Print-Friendly Worksheet`                  | Captures and copies the module content.                                        |
| **Add Quiz**                | `//*[name()='svg'][@name='ACPGenerate24']`          | Adds a quiz to the module with specified questions and details.                |
| **Enable Learning Progress**| `//span[normalize-space()='Include in Learning Progress']` | Includes the quiz in the learning progress system.                             |
| **Approval**                | `Approve32`                                         | Approves the module after processing.                                          |

---

## **Customization**

- Modify the **start** and **end** variables to adjust the range of modules.
- Update the quiz details or other module content as required in the script.

---

## **Caveats**
- Ensure the selectors used in the script match the latest VLE UI.
- Some interactions may require additional error handling for unexpected UI changes.
- Use `wait` commands appropriately to account for varying network or system performance.

---

## **Support**
For troubleshooting or additional features, contact your EdTech support team or administrator.
