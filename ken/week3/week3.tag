// start both challenge website and Windows desktop application
https://developer.automationanywhere.com/challenges/automationanywherelabs-employeedatamigration.html
//run cmd /c start c:/Users/your_userid/Desktop/EmployeeList.exe
//run cmd /c start D:\flows\ken\week3\EmployeeList.exe
// make sure you download the legacy app that run on Windows
// put it on the usual C:\rpa\tagui\flows\ location
run cmd /c start C:\rpa\tagui\flows\ken\week3\EmployeeList.exe

// start automation loop to process all records
for record from 1 to 10
     read employeeID to employeeID
     
     // fetch some details from REST API call
     api https://botgames-employee-data-migration-vwsrh7tyda-uc.a.run.app/employees?id=`employeeID`
     phone = api_json.phoneNumber
     startDate = api_json.startDate

     // fetch remaining details from desktop app
     keyboard `employeeID`[tab][enter]

     keyboard [tab][tab]
     keyboard [ctrl]c
     firstName = clipboard()

     keyboard [tab]
     keyboard [ctrl]c
     lastName = clipboard()

     keyboard [tab][tab]
     keyboard [ctrl]c
     email = clipboard()

     keyboard [tab]
     keyboard [ctrl]c
     city = clipboard()

     keyboard [tab]
     keyboard [ctrl]c
     state = clipboard()

     keyboard [tab]
     keyboard [ctrl]c
     zip = clipboard()

     keyboard [tab]
     keyboard [ctrl]c
     title = clipboard()

     keyboard [tab]
     keyboard [ctrl]c
     department = clipboard()

     keyboard [tab]
     keyboard [ctrl]c
     manager = clipboard()

     keyboard [tab][tab]
     keyboard [ctrl]a
	
     // fill up collected details into target website
     type firstName as `firstName`
     type lastName as `lastName`
     type phone as `phone`
     type email as `email`
     type city as `city`
     select state as `state`
     type zip as `zip`
     type #title as `title`
     select department as `department`
     type startDate as `startDate`
     type manager as `manager`
     click submitButton
wait 3
snap page to week3results.png
//wait 10 seconds