# +
***Setting***
Documentation  All keywords of order will be implemented hear

Library  RPA.HTTP
Library  RPA.Tables
Library    RPA.Dialogs
# -

***keyword***
Get URL from User
    Add heading        Order file URL
    Add text           Please provide the complete URL to the CSV file, which contains all the orders.
    Add text input     url    label=URL for order file
    ${input} =         Run dialog
    [Return]           ${input.url}

***keyword***
Get orders
    ${download_url}=  Get URL from User
    Download   ${download_url}  overwrite=True
    ${data}=  Get Orders Data
    [Return]  ${data}

***keyword***
Get Orders Data 
       ${ordersData}=  Read Table From Csv  orders.csv  dialect=excel  header=True 
    [Return]  ${ordersData}


