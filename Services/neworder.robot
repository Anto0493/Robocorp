# +
***setting***
Documentation  All Keyword related to generation of a new robot

Library  RPA.PDF
# -

***Variables***
${order_number}
${GLOBAL_RETRY_AMOUNT}=  10x
${GLOBAL_RETRY_INTERVAL}=  1s

***keyword***
Fill the form
    [Arguments]  ${order}
    # Assigning values to varible
    ${robo_head}=  Convert To Integer  ${order}[Head]
    ${robo_body}=  Convert To Integer  ${order}[Body]
    ${robo_legs}=  Convert To Integer  ${order}[Legs]
    ${delivery_address}=  Convert To String  ${order}[Address]
    # Setting value to html components
    Select From List By Value   id:head  ${robo_head}
    Click Element   id-body-${robo_body}
    Input Text      id:address    ${delivery_address}
    Input Text      xpath:/html/body/div/div/div[1]/div/div[1]/form/div[3]/input    ${robo_legs}

***keyword***
Preview the robot
    Click Element    id:preview
    Wait Until Element Is Visible    id:robot-preview

***keyword***
Submit the order untill success
    Click Element    order
    Element Should Be Visible    xpath://div[@id="receipt"]/p[1]
    Element Should Be Visible    id:order-completion

***keyword***
Submit the order
    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}  Submit the order untill success


***keyword***
Store the receipt as a PDF file
    [Arguments]    ${order_number}
    Wait Until Element Is Visible    id:order-completion
    ${order_number}=    Get Text    xpath://div[@id="receipt"]/p[1]
    #Log    ${order_number}
    ${receipt_html}=    Get Element Attribute    id:order-completion    outerHTML
    Html To Pdf    ${receipt_html}    ${CURDIR}${/}output${/}receipts${/}${order_number}.pdf
    [Return]    ${CURDIR}${/}output${/}receipts${/}${order_number}.pdf

***keyword***
Take a screenshot of the robot
    [Arguments]    ${order_number}
    Screenshot     id:robot-preview    ${CURDIR}${/}output${/}${order_number}.png
    [Return]       ${CURDIR}${/}output${/}${order_number}.png

***keyword***
Embed the robot screenshot to the receipt PDF file
    [Arguments]    ${screenshot}   ${pdf}
    Open Pdf       ${pdf}
    Add Watermark Image To Pdf    ${screenshot}    ${pdf}
    Close Pdf      ${pdf}

***keyword***
Go to order another robot
    Click Button    order-another

***keyword***
Generate New Order
    [Arguments]  ${order}
    Fill the form    ${order}
    Preview the robot
    Submit the order
    ${pdf}=    Store the receipt as a PDF file    ${order}[Order number]
    ${screenshot}=    Take a screenshot of the robot    ${order}[Order number]
    Embed the robot screenshot to the receipt PDF file    ${screenshot}    ${pdf}
    Go to order another robot
