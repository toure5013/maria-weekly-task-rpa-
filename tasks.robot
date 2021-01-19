*** Settings ***
Documentation    BISMILLAH ROBOT FRAMEWORK
Library  RPA.Browser


*** Keywords ***
BISMILLAH KEYWORDS
    [Documentation]  Open Google in a browser |  make a screeshot | type BISMILLAH | and make a screeshot
    [Arguments]  ${word_to_search}=${EMPTY}
    Open Available Browser  http://google.com
    screenshot
    input text when element is visible   css:input.gLFyf  ${word_to_search}
    sleep  1 second
    click element when visible  css:input.gNO89b
    screenshot


*** Tasks ***
BISMILLAH TASK
    [Documentation]    My main function using to call others functions called keywords
    BISMILLAH KEYWORDS  BISMILLAH
    [Teardown]    Close All Browsers