*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${BROWSER}    Chrome
*** Keywords ***
Begin Web Test
    #mock user-agent and window size to bypass Amazon CAPTCHA
    Open Browser    about:blank    ${BROWSER}  options=add_argument("--lang=en-US");add_argument("--window-size=1920,1080");add_argument("--user-agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36")
    Maximize Browser Window

End Web Test
    Close Browser