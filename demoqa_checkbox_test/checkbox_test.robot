*** Settings ***
Library           SeleniumLibrary
Library           ScreenCapLibrary

Suite Setup       Start Video Recording
Suite Teardown    Stop Video Recording

*** Variables ***
${URL}            https://demoqa.com/checkbox

*** Test Cases ***

Seleccionar múltiples checkboxes
    [Tags]    TodosLosCheckboxes
    Close All Browsers
    Open Browser    ${URL}    chrome    options=add_argument("--disable-popup-blocking"); add_argument("--disable-extensions"); add_argument("--blink-settings=imagesEnabled=false")
    Maximize Browser Window
    Wait Until Element Is Visible    css=button.rct-option-expand-all    timeout=10s
    Click Element With JS    button.rct-option-expand-all
    Sleep    1s

    # Notes
    Click Element    xpath=//*[@id="tree-node-notes"]/../span[@class="rct-checkbox"]
    Sleep    2s

    # Commands
    Click Element    xpath=//*[@id="tree-node-commands"]/../span[@class="rct-checkbox"]
    Sleep    2s

    # React
    Click Element    xpath=//*[@id="tree-node-react"]/../span[@class="rct-checkbox"]
    Sleep    2s

    # Angular
    Click Element    xpath=//*[@id="tree-node-angular"]/../span[@class="rct-checkbox"]
    Sleep    2s

    # Veu
    Click Element    xpath=//*[@id="tree-node-veu"]/../span[@class="rct-checkbox"]
    Sleep    2s

    # Public
    Click Element    xpath=//*[@id="tree-node-public"]/../span[@class="rct-checkbox"]
    Sleep    2s

    # Private
    Click Element    xpath=//*[@id="tree-node-private"]/../span[@class="rct-checkbox"]
    Sleep    2s

    # Classified
    Click Element    xpath=//*[@id="tree-node-classified"]/../span[@class="rct-checkbox"]
    Sleep    2s

    # General
    Click Element    xpath=//*[@id="tree-node-general"]/../span[@class="rct-checkbox"]
    Sleep    2s

    # Word File
    Click Element    xpath=//*[@id="tree-node-wordFile"]/../span[@class="rct-checkbox"]
    Sleep    2s

    # Excel File
    Click Element    xpath=//*[@id="tree-node-excelFile"]/../span[@class="rct-checkbox"]
    Sleep    3s

    Capture Page Screenshot
    Close Browser

Seleccionar checkboxes Notes y Commands
    [Tags]    NotesCommands
    Close All Browsers
    Open Browser    ${URL}    chrome    options=add_argument("--disable-popup-blocking"); add_argument("--disable-extensions"); add_argument("--blink-settings=imagesEnabled=false")
    Maximize Browser Window
    Wait Until Element Is Visible    css=button.rct-option-expand-all    timeout=10s
    Click Element With JS    button.rct-option-expand-all
    Sleep    1s
    Click Element    xpath=//*[@id="tree-node-notes"]/../span[@class="rct-checkbox"]     # Notes
    Sleep    2s
    Click Element    xpath=//*[@id="tree-node-commands"]/../span[@class="rct-checkbox"]  # Commands
    Sleep    3s
    Capture Page Screenshot
    Close Browser

Seleccionar checkboxes React, Angular y Veu
    [Tags]    ReactAngularVeu
    Close All Browsers
    Open Browser    ${URL}    chrome    options=add_argument("--disable-popup-blocking"); add_argument("--disable-extensions"); add_argument("--blink-settings=imagesEnabled=false")
    Maximize Browser Window
    Wait Until Element Is Visible    css=button.rct-option-expand-all    timeout=10s
    Click Element With JS    button.rct-option-expand-all
    Sleep    1s
    Click Element    xpath=//*[@id="tree-node-react"]/../span[@class="rct-checkbox"]       # React
    Sleep    2s
    Click Element    xpath=//*[@id="tree-node-angular"]/../span[@class="rct-checkbox"]     # Angular
    Sleep    2s
    Click Element    xpath=//*[@id="tree-node-veu"]/../span[@class="rct-checkbox"]         # Veu
    Sleep    3s
    Capture Page Screenshot
    Close Browser

Seleccionar checkboxes Public, Private, Classified y General
    [Tags]    PublicPrivateClassifiedGeneral
    Close All Browsers
    Open Browser    ${URL}    chrome    options=add_argument("--disable-popup-blocking"); add_argument("--disable-extensions"); add_argument("--blink-settings=imagesEnabled=false")
    Maximize Browser Window
    Wait Until Element Is Visible    css=button.rct-option-expand-all    timeout=10s
    Click Element With JS    button.rct-option-expand-all
    Sleep    1s
    Click Element    xpath=//*[@id="tree-node-public"]/../span[@class="rct-checkbox"]         # Public
    Sleep    2s
    Click Element    xpath=//*[@id="tree-node-private"]/../span[@class="rct-checkbox"]        # Private
    Sleep    2s
    Click Element    xpath=//*[@id="tree-node-classified"]/../span[@class="rct-checkbox"]     # Classified
    Sleep    2s
    Click Element    xpath=//*[@id="tree-node-general"]/../span[@class="rct-checkbox"]        # General
    Sleep    3s
    Capture Page Screenshot
    Close Browser

Seleccionar checkboxes Word File y Excel File
    [Tags]    WordFileExcelFile
    Close All Browsers
    Open Browser    ${URL}    chrome    options=add_argument("--disable-popup-blocking"); add_argument("--disable-extensions"); add_argument("--blink-settings=imagesEnabled=false")
    Maximize Browser Window
    Wait Until Element Is Visible    css=button.rct-option-expand-all    timeout=10s
    Click Element With JS    button.rct-option-expand-all
    Sleep    1s
    Click Element    xpath=//*[@id="tree-node-wordFile"]/../span[@class="rct-checkbox"]         # Word File
    Sleep    2s
    Click Element    xpath=//*[@id="tree-node-excelFile"]/../span[@class="rct-checkbox"]        # Excel File
    Sleep    3s
    Capture Page Screenshot
    Close Browser





*** Keywords ***
Click Element With JS
    [Arguments]    ${selector}
    Execute JavaScript    document.querySelector("${selector}").click()
