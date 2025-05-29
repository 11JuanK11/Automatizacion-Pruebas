*** Settings ***
Library           SeleniumLibrary
Library           ScreenCapLibrary
Library           AutoRecorder

Test Setup        Start Video Recording
Test Teardown     Stop Video Recording

*** Variables ***
${URL}            https://demoqa.com/
${BROWSER}        chrome

*** Test Cases ***
Test Radio Button Yes
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

    Click Element    xpath=//div[@class='card-body']/h5[text()='Elements']
    Click Element    xpath=//span[text()='Radio Button']
    Sleep    1s

    Click Element    xpath=//label[@for='yesRadio']
    Wait Until Page Contains Element    xpath=//span[@class='text-success']    timeout=5s
    Element Text Should Be    xpath=//span[@class='text-success']    Yes

    Capture Page Screenshot
    Close Browser


Test Radio Button Impressive
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

    Click Element    xpath=//div[@class='card-body']/h5[text()='Elements']
    Click Element    xpath=//span[text()='Radio Button']
    Sleep    1s

    Click Element    xpath=//label[@for='impressiveRadio']
    Wait Until Page Contains Element    xpath=//span[@class='text-success']    timeout=5s
    Element Text Should Be    xpath=//span[@class='text-success']    Impressive

    Capture Page Screenshot
    Close Browser


Test Radio Button No (Deshabilitado)
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

    Click Element    xpath=//div[@class='card-body']/h5[text()='Elements']
    Click Element    xpath=//span[text()='Radio Button']
    Sleep    1s

    Element Should Be Disabled    id=noRadio

    Capture Page Screenshot
    Close Browser
