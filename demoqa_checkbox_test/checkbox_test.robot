*** Settings ***
Library           SeleniumLibrary
Library           ScreenCapLibrary

Suite Setup       Start Video Recording
Suite Teardown    Stop Video Recording

*** Variables ***
${URL}            https://demoqa.com/checkbox

*** Test Cases ***
Seleccionar checkbox Desktop
    [Tags]    Desktop
    Close All Browsers
    Open Browser    ${URL}    chrome
    Maximize Browser Window
    Wait Until Element Is Visible    css=button.rct-option-expand-all    timeout=10s
    Click Element With JS    button.rct-option-expand-all
    Sleep    1s
    Click Element    xpath=//*[@id="tree-node"]/ol/li/ol/li[1]/span/label/span[1]        # Desktop
    Sleep    1s
    Capture Page Screenshot
    Close Browser

Seleccionar checkboxes Notes y Commands
    [Tags]    NotesCommands
    Close All Browsers
    Open Browser    ${URL}    chrome
    Maximize Browser Window
    Wait Until Element Is Visible    css=button.rct-option-expand-all    timeout=10s
    Click Element With JS    button.rct-option-expand-all
    Sleep    1s
    Click Element    xpath=//*[@id="tree-node-notes"]/../span[@class="rct-checkbox"]     # Notes
    Click Element    xpath=//*[@id="tree-node-commands"]/../span[@class="rct-checkbox"]  # Commands
    Sleep    1s
    Capture Page Screenshot
    Close Browser

*** Keywords ***
Click Element With JS
    [Arguments]    ${selector}
    Execute JavaScript    document.querySelector("${selector}").click()
