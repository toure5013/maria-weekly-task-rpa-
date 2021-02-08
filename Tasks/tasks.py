from RPA.Browser.Selenium import Browser
from RPA.HTTP import HTTP
from RPA.PDF import PDF
from RPA.Excel.Files import Files

URL_robotsparebin = "https://robotsparebinindustries.com/"
URL_sales_report_excel_file = "https://robotsparebinindustries.com/SalesData.xlsx"
username = "maria"
password = "thoushallnotpass"


# The browser
browser_lib = Browser()
excel_lib = Files()
http_lib = HTTP()
pdf_lib = PDF()

def open_robotsparebin_intranet(url: str):
    browser_lib.open_available_browser(url)


def login_to_the_inranet(login, password):
    print(login, password)
    browser_lib.input_text_when_element_is_visible('css:input#username', username)
    browser_lib.input_text_when_element_is_visible('css:input#password', password)
    browser_lib.click_button_when_visible('css:button[type="submit"]')


def download_sales_report_excel_file(excel_file_url):
    http_lib.download(excel_file_url, overwrite=True)


def open_excel_file_got_the_datas(excel_file_path):
    try:
        excel_lib.open_workbook(excel_file_path)
        table = excel_lib.read_worksheet_as_table(header=True)
    finally:
        excel_lib.close_workbook()

    return table



def fill_sale_information_for_one_person(saleData):
    browser_lib.input_text_when_element_is_visible('id:firstname', saleData["First Name"])
    browser_lib.input_text_when_element_is_visible('id:lastname', saleData["Last Name"])
    browser_lib.input_text_when_element_is_visible('id:salesresult', saleData["Sales"])
    sale_target_stringed = str(saleData["Sales Target"])
    #browser_lib.find_elements('css:#salestarget[value="'+ sale_target_stringed +'"]')
    browser_lib.click_element_when_visible('css:select > option[value="{sale_target_stringed}"]'.format(sale_target_stringed=sale_target_stringed))
    browser_lib.click_button_when_visible('css:button[type="submit"]')



def loop_sale_informations_and_send_to_fill_keywords(table_salesData):
    for saleData in table_salesData:
        print(saleData)
        fill_sale_information_for_one_person(saleData)
    print("All data filled")


def capture_sales_report_summary():
    browser_lib.screenshot('css:div.sales-summary', './results/report.png')


def export_sales_table_to_pdf():
    """
    :param content:
    :return:
    """
    orders = ["item 1", "item 2", "item 3"]
    vars = {
        "name": "Robot Process",
        "email": "robot@domain.com",
        "zip": "00100",
        "items": "<br/>".join(orders),
    }
    content = "<span style='color:red; font-size:1.5em'>content</span>"
    pdf_lib.html_to_pdf(content, "./results/report.pdf")
    #pdf_lib.template_html_to_pdf("order.template", "order.pdf", content)


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
    sales_report_data = open_excel_file_got_the_datas("./SalesData.xlsx")
    loop_sale_informations_and_send_to_fill_keywords(sales_report_data)
    capture_sales_report_summary();
    export_sales_table_to_pdf()



if __name__ == "__main__":
    main()
