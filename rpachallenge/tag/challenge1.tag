// from MuhammadArdyansyah on telegram https://web.telegram.org/z/#-1299183642 on 20220422

arr = [challenge.xlsx]Sheet1!A2:G11

https://rpachallenge.com/
click //*[text()="Start"]

xpath_input = ['//*[@ng-reflect-name="labelFirstName"]', '//*[@ng-reflect-name="labelLastName"]', '//*[@ng-reflect-name="labelCompanyName"]', '//*[@ng-reflect-name="labelRole"]', '//*[@ng-reflect-name="labelAddress"]', '//*[@ng-reflect-name="labelEmail"]', '//*[@ng-reflect-name="labelPhone"]']
//xpath_input = ['//*[@id="TgC2m"]', '//*[@ng-reflect-name="labelLastName"]', '//*[@ng-reflect-name="labelCompanyName"]', '//*[@ng-reflect-name="labelRole"]', '//*[@ng-reflect-name="labelAddress"]', '//*[@ng-reflect-name="labelEmail"]', '//*[@ng-reflect-name="labelPhone"]']

for row from 0 to arr.length-1
  for col from 0 to arr[row].length-1
    type `xpath_input[col]` as `arr[row][col]`
  click //*[@value="Submit"]

snap page to score.png
wait 3