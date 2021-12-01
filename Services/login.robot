***Setting***
Documentation  Roboto Will go to the given url and login to the application with the given creadetils
Library  RPA.Browser
Library    RPA.Robocorp.Vault
Resource  common.robot

***keyword***
Open the robot order website
    Open Available Browser  https://robotsparebinindustries.com/
    Login Application

***keyword***
Login Application
    ${secret}=    Get Secret    credentials
    Input Text        id:username   ${secret}[username]
    Input Password    id:password   ${secret}[password]
    Submit Form
    Wait Until Page Contains Element  id:sales-form
    Click Link    //a[@href="#/robot-order"]
    Close the annoying modal
