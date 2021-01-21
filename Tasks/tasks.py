from RPA.Browser.Selenium import Browser
from RPA.HTTP import HTTP
from RPA.PDF import PDF
from RPA.Excel import Files

URL_robotsparebin = "https://robotsparebinindustries.com/"
URL_sales_report_excel_file = "https://robotsparebinindustries.com/SalesData.xlsx"
username = "maria"
password = "thoushallnotpass"

# The browser
browser = Browser()
excel = Files()


def open_robotsparebin_intranet(url: str):
    browser.open_available_browser(url)


def login_to_the_inranet(login, password):
    print(login, password)
    browser.input_text_when_element_is_visible('css:input#username', username)
    browser.input_text_when_element_is_visible('css:input#password', password)
    browser.click_button_when_visible('css:button[type="submit"]')


def download_sales_report_excel_file(excel_file_url):
    # HTTP.download(url=excel_file_url)
    # Files.open_workbook("./SalesData.xlsx")
    print('...')


def loop_sale_informations_and_send_to_fill_keywords():
    print("...")


def capture_sales_report_summary():
    print("...")


def export_sales_table_to_pdf():
    print('....')$


def main():
    '''
        This is the main function that will execute the completely maria weekly task
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
    '''
    print("Main task")
    open_robotsparebin_intranet(URL_robotsparebin)
    login_to_the_inranet(username, password)
    download_sales_report_excel_file(URL_sales_report_excel_file)


if __name__ == "__main__":
    main()
