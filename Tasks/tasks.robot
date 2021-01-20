*** Settings ***
Documentation  Acomplish maria weekly task that consist to download a file and fill a web page
Library         RPA.Browser
Library         RPA.Excel.Files
Library         RPA.HTTP

*** Variables ***
${robotsparebin_web_url}=  https://robotsparebinindustries.com/
${username}=  maria
${password}=  thoushallnotpass

${exel_file_url}=  ${EMPTY}


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
    click button when visible  //*[@id="root"]/div/div/div/div[1]/form/button



*** Keywords ***
Dowload and open excel file
    Dowload and open excel file  ${exel_file_url}


*** Keywords ***
Convert to pdf file

*** Keywords ***
Send report

*** Tasks ***
Dowload excel file of sales report and fill the web page
    [tags]  accomplish maria task
    Open Robotsparebin intranet
    Login to Robotsparebin web page
    Dowload and open excel file
    Fill the web page
    Convert to pdf file
    Send report