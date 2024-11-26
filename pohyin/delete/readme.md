Managing MOE Library modules, especially those in draft or rejected status, can be a time-consuming process. Teachers and administrators often face the repetitive task of reviewing, filtering, and deleting outdated or unnecessary content. Enter RPA (Robotic Process Automation) powered by TagUI, an open-source tool that can automate these mundane and tedious tasks.
This blog explores a recently developed TagUI script that automates the deletion of MOE Library modules, demonstrating how this simple automation can save hours of work and enhance productivity.

The Problem
Imagine you are responsible for maintaining the MOE Library, ensuring that only relevant, high-quality resources are available for students and educators. You need to:

Log in to the MOE Learning Management System (SLS).
Filter lessons or modules by their status (e.g., draft, rejected).
Manually review and delete unwanted modules one by one.
This workflow, while necessary, is incredibly repetitive and prone to human error. It also consumes valuable time that could be better spent creating new resources or providing support to teachers.

The Solution: TagUI RPA Script
With the TagUI automation script, this entire process is streamlined. Here's what the script does:

Automates Login: Automatically logs into the SLS platform using pre-defined credentials.
Filters Draft and Rejected Modules: Navigates directly to the module management page and filters resources by their status and subject.
Batch Deletes Modules: Opens each draft or rejected module, initiates the deletion process, and confirms the action—all without manual intervention.
Repeats the Process: Iterates through a pre-defined number of modules (customizable) until all are processed.
Why This is So Cool
1. Time-Saving Brilliance
Imagine needing to delete 50 modules. A manual approach could take hours. With this script, the entire process is automated and completed in minutes, freeing up your time for more critical tasks.

2. Consistency and Accuracy
Automation ensures no modules are skipped or deleted incorrectly. The script follows a precise workflow, reducing the likelihood of human error.

3. Scalability
Whether you need to process 10 modules or 100, the script can handle it. Simply adjust the iteration count, and the RPA tool does the heavy lifting.

4. Empowering Educators
By removing the administrative burden, educators can focus on their primary mission: teaching and developing impactful learning resources.

How It Works
Here’s a sneak peek at the workflow:

Login Automation: The script navigates to the SLS login page and inputs the user's credentials automatically.

Filter Modules: It goes straight to the management page for modules, filtering by draft or rejected status.

Automated Deletion:

Opens each module in the filtered list.
Initiates the deletion process by interacting with the user interface.
Confirms the deletion and closes the module.
Repeat Until Done: The script repeats this process for a specified number of iterations or until no modules remain.

Example Script
Here’s an excerpt of the script for context:

tagui
Copy code
// Navigate to the SLS login page
https://vle.learning.moe.edu.sg/login
wait 5

//live
//wait 3
click //button[normalize-space()='Login With SLS']
//type bx--text-input as [clear]MOE-XXXXXX

//click //input[@placeholder='SLS Password'] 
//type //input[@placeholder='SLS Password'] as [clear]PASSWORD

click //button[normalize-space()='Login']
//live

// filter to correct subject and draft 
//https://vle.learning.moe.edu.sg/manage-resource?resource=LESSON&location=MOE&ownerGroups=1126,1121,1174,1163&status=DRAFT&subjects=12790
//
https://vle.learning.moe.edu.sg/manage-resource?resource=LESSON&location=MOE&ownerGroups=1126,1121,1174,1163&status=REJECTED&subjects=12790
wait 5 // ensure new data is read on browser after taking first result again

// does not have graceful handling 20 is just a number for the first page
// to do more pages restart the flow again type delete.tag in cmd
end = 20
for i from 1 to end
 
    click (//a[@tag='component'][normalize-space()='Open'])[`i`]
    popup cover
        {
        click //button[@aria-controls='lesson-submenu']//*[name()='svg']
        click //li[@class='delete moe-library']//a[@class='cv-link bx--link']
        click OK
        dom window.close()
        }

The Bigger Picture
This script is more than just a neat trick—it’s a step toward embracing automation in education. By reducing administrative overhead, educators can focus on high-value activities like:

Developing new teaching materials.
Collaborating with colleagues to improve pedagogy.
Engaging with students for personalized learning experiences.
Moreover, the potential for automation goes beyond module management. Think of grading assignments, generating reports, or even curating content recommendations for students. The possibilities are endless.
