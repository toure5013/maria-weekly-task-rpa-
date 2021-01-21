*** Settings ***
Documentation  Acomplish maria weekly task that consist to download a file and fill a web page
Library         RPA.Browser.Selenium
Library         RPA.Excel.Files
Library         RPA.HTTP
Library         RPA.PDF

*** Variables ***
${robotsparebin_web_url}=  https://robotsparebinindustries.com/
${username}=  maria
${password}=  thoushallnotpass
${exel_file_url}=   https://robotsparebinindustries.com/SalesData.xlsx
${default_browser}=  chrome



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
    ${all_sales_reps}=       Read Worksheet As Table     header=True
    [Teardown]       Close workbook
    [Return]  ${all_sales_reps}


*** Keywords ***
Select value in a select
    [Arguments]  ${select_identifier}=${EMPTY}  ${element_to_select_identifier}=${EMPTY}
    #Click Element   ${select_identifier}
    click element when visible  ${element_to_select_identifier}
    sleep  1 second


*** Keywords ***
Fill Sale information form for one person
    [Arguments]  ${sales_rep}=${EMPTY}
    input text when element is visible  id:firstname  ${sales_rep}[First Name]
    input text when element is visible  id:lastname  ${sales_rep}[Last Name]
    input text when element is visible  id:salesresult  ${sales_rep}[Sales]
    #Select value in a select   id:salestarget   css:option[value="${sales_rep}[Sales Target]"]
    ${sale_target_as_string}=    Convert To String    ${sales_rep}[Sales Target]  #we convert the data to string here
    Select From List By Value    id:salestarget    ${sale_target_as_string}
    click element when visible  css:button[type="submit"]
    sleep  1 second



*** Keywords ***
Loop sale informations and send to fill keywords
    [Arguments]  @{all_sales_reps}=${EMPTY}
    FOR    ${sales_rep}    IN    @{all_sales_reps}
        Fill Sale information form for one person    ${sales_rep}
    END



*** Keywords ***
Capture sales report summary
    Screenshot  css:div.sales-summary   ${OUTPUTDIR}/report_summary.png #${CURDIR}${/}output${/}sales_summary.png


*** Keywords ***
Export sales table to pdf
    Wait Until Element Is Visible  id:sales-results
    ${sales_results_html}=    Get Element Attribute    id:sales-results    outerHTML
    #Html To Pdf    ${sales_results_html}    ${CURDIR}${/}output${/}sales_results.pdf
    Template HTML to PDF   ${TEMPLATE}  ${PDF}  ${VARS}
*** Keywords ***
Send report
    log  "send"


*** Keywords ***
Logout to Robotsparebin web page and close browser
    [Documentation]   We logout  user after all task done
    click element when visible  id:logout
    Close Browser


*** Tasks ***
Create PDF from HTML template
    Template HTML to PDF   ${TEMPLATE}  ${PDF}  ${VARS}


*** Tasks ***
Dowload excel file of sales report and fill the web page
    [tags]  accomplish maria task
    Open Robotsparebin intranet
    Login to Robotsparebin web page
    ${all_sales_reps}=  Dowload and open excel file of sales data
    Loop sale informations and send to fill keywords  ${all_sales_reps}
    Capture sales report summary
    Export sales table to pdf
    Send report
    [Teardown]  Logout to Robotsparebin web page and close browser