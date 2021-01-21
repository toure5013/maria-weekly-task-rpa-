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
        ${table}=       Read Worksheet As Table     header=True
    Close Workbook
    FOR     ${row}  IN  @{table}
        Log     ${row}
    END



*** Keywords ***
Fill and submit the form of sale information
    log("ok")



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
    Dowload and open excel file of sales data
    Fill and submit the form of sale information
    Convert to pdf file
    Send report