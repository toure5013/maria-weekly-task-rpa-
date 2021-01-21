*** Settings ***
Documentation  Acomplish maria weekly task that consist to download a file and fill a web page
Library         RPA.Browser
Library         RPA.Excel.Files
Library         RPA.HTTP


*** Variables ***
${robotsparebin_web_url}=  https://robotsparebinindustries.com/
${username}=  maria
${password}=  thoushallnotpass
${exel_file_url}=   https://robotsparebinindustries.com/SalesData.xlsx
${default_browser}=  chrome
${sale_target}=  3000



*** Keywords ***
Open Robotsparebin intranet
    open available browser  ${robotsparebin_web_url}
    does page contain  The leader in refurbished and dubious quality spare parts for robots, since 1982!



*** Keywords ***
Login to Robotsparebin web page
    input text when element is visible  css:input#username  ${username}
    sleep  1 second
    input text when element is visible  css:input#password  ${password}
    sleep  1 second
    click button when visible  xpath://*[@id="root"]/div/div/div/div[1]/form/button
    Wait Until Page Contains Element    id:sales-form



*** Keywords ***
Dowload and open excel file of sales data
    Download  ${exel_file_url}   overwrite=true
    Open workbook  SalesData.xlsx
    ${worksheet}=  Read Worksheet  SalesData.xlsx
    ${table}=      Create table     ${worksheet}
    [Teardown]       Close workbook
    [Return]  ${table}


*** Keywords ***
Select value in a select
    [Arguments]  ${select_identifier}=${EMPTY}  ${element_to_select_identifier}=${EMPTY}
    Click Element   ${select_identifier}
    sleep  1 second
    Mouse Down    ${element_to_select_identifier}=${EMPTY}
    Click Element  ${element_to_select_identifier}=${EMPTY}
    sleep  1 second

*** Keywords ***
Fill and submit the form of sale information
    [Arguments]  ${table}=${EMPTY}
    input text when element is visible  id:firstname  TOURE
    input text when element is visible  id:lastname  SOULEYMANE
    Select value in a select   id:salestarget   css:option[value="${sale_target}"]
    input text when element is visible  id:salesresult  2000
    Log  ${table}



*** Keywords ***
Convert to pdf file
    log("ok")


*** Keywords ***
Send report
    log('send')



*** Tasks ***
Dowload excel file of sales report and fill the web page
    [tags]  accomplish maria task
    Open Robotsparebin intranet
    Login to Robotsparebin web page
    ${sales_table}=  Dowload and open excel file of sales data
    Fill and submit the form of sale information  ${sales_table}
    Convert to pdf file
    Send report