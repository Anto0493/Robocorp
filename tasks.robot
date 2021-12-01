# +
*** Settings ***
Documentation   Orders robots from RobotSpareBin Industries Inc.
...             Saves the order HTML receipt as a PDF file.
...             Saves the screenshot of the ordered robot.
...             Embeds the screenshot of the robot to the PDF receipt.
...             Creates ZIP archive of the receipts and the images.

Resource  Services/login.robot
Resource  Services/orders.robot
Resource  Services/common.robot
Resource  Services/neworder.robot
Library   RPA.Archive
Library   OperatingSystem
# -


***keyword***
Create a ZIP file of the receipts
    Archive Folder With Zip  ${CURDIR}${/}Services${/}output${/}receipts  ${CURDIR}${/}receipt.zip

*** Keywords ***
Log Out And Close The Browser
    Click Button    Log out
    Close Browser

***keyword***
Cleanup
    [TearDown]  Log Out And Close The Browser
    Remove Directory  ${CURDIR}${/}Services${/}output  recursive=True	

*** Tasks ***
Order robots from RobotSpareBin Industries Inc 
    Open the robot order website
    ${orders}=    Get orders
    FOR    ${row}    IN    @{orders} 
         Generate New Order  ${row}
         Close the annoying modal
    END
   Create a ZIP file of the receipts
   Cleanup


