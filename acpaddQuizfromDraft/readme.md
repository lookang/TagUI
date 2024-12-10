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
Here's an improved version of the **ReadMe** for automating module management in the VLE, especially with adding a quiz using the Authoring Co-Pilot:

---

# Automating Module Management in VLE with Authoring Co-Pilot

This script automates interactions with the **Virtual Learning Environment (VLE)** at `https://vle.learning.moe.edu.sg/`, enabling efficient management of modules. It includes logging in, navigating resources, extracting information, and adding quizzes (5 MCQs and 2 short-answer questions) using the Authoring Co-Pilot.

---

## Example Video  
**[Watch Video](https://www.youtube.com/watch?v=xMvQe0kp068&t=8s)**  
This video demonstrates how to use this automation effectively.

---

## **Key Features**
- Automated login and navigation through VLE resources.
- Addition of quizzes with **5 MCQs and 2 short-answer questions**.
- Use of the Authoring Co-Pilot to streamline quiz creation.
- Inclusion of extracted content from the Knowledge Base into modules.

---

## **Prerequisites**
1. **Environment Setup**  
   Ensure you have the following installed and configured:
   - **RPA Tool**: Recommended: [TagUI](https://github.com/tebelorg/tagui).
   - **Web Browser Extensions/Drivers**: Ensure compatibility with your browser (e.g., ChromeDriver for Chrome).

2. **User Permissions**  
   - You must have access to manage modules and use the Authoring Co-Pilot.

3. **Dependencies**  
   - Ensure stable internet connectivity and an updated browser for seamless operations.

---

## **Automation Script Overview**

### **Login**
Automates the login process using Single Login Service (SLS) credentials:
- Clicks the "Login With SLS" button.
- Waits for the login to complete.

### **Module Management**
1. **Navigate to the Module List**  
   Access the management page for draft or unpublished resources:
   ```
   https://vle.learning.moe.edu.sg/manage-resource?resource=LESSON&location=MOE&ownerGroups=1126,1121,1174,1163&status=DRAFT,UNPUBLISHED&subjects=611
   ```
2. **Process Modules by Index**  
   The script loops through specified modules, performs actions like:
   - Extracting content in print-friendly format.
   - Adding quizzes.

### **Add a Quiz**
- Opens the Authoring Co-Pilot.
- Adds a new quiz with:
  - **5 MCQs**.
  - **2 Short-answer Questions**.
- Sets metadata like **Learning Progress Inclusion**.
- Approves the module.

---

## **How to Run the Script**

1. **Set the Module Range**  
   Update the script variables to define the range of modules to process:
   ```rpa
   start = 1
   end = 20
   ```

2. **Execute the Script**  
   Run the script using your preferred RPA tool. Adjust wait times (`wait`) to match your system's performance.

3. **Verify Results**  
   Review the modules manually to ensure the quizzes were added successfully.

---

## **Example Code Snippet for Quiz Creation**
```rpa
// Add Quiz using Authoring Co-Pilot
click //*[@id="main-content"]/div/div/section/div/div[2]/div[2]/div/div[1]/table/tbody/tr[`n`]/td[1]/div/div/a
popup cover {
    click ACPGenerate24
    wait 3
    type bx--text-input as [clear]Quiz
    type bx--text-area as 5 MCQ and 2 short answers
    click Add
}
```

---

## **Additional Notes**
- Use the provided video tutorial for visual guidance.
- Ensure that the Authoring Co-Pilot is accessible in your VLE account.
- Update the script if UI changes occur in the VLE platform.

--- 

By automating these repetitive tasks, you can save time and focus on creating impactful educational content.
## **Support**
For troubleshooting or additional features, contact your EdTech support team or administrator.
