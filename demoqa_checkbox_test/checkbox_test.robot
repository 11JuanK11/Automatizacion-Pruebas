*** Settings ***
Library           SeleniumLibrary
Library           DataDriver    checkbox_data.csv
Library           ScreenCapLibrary
Suite Setup       Start Video Recording
Suite Teardown    Stop Video Recording

*** Variables ***
${URL}    https://demoqa.com/checkbox

*** Test Cases ***
Seleccionar nodo desde CSV
    [Template]    Ejecutar prueba con nodo
    ${folder}     ${node}

*** Keywords ***
Ejecutar prueba con nodo
    [Arguments]    ${folder}    ${node}
    Close All Browsers
    Open Browser    ${URL}    chrome
    Maximize Browser Window
    Sleep    1s
    Click Element    xpath=//button[@title='Expand all']
    Sleep    1s

    Run Keyword If    '${folder}'=='Desktop'    Expand Folder    Desktop
    ...    ELSE IF    '${folder}'=='Documents'    Expand Folder    Documents
    ...    ELSE IF    '${folder}'=='Office'    Expand Folder    Office
    ...    ELSE IF    '${folder}'=='Downloads'    Expand Folder    Downloads
    ...    ELSE IF    '${folder}'=='All'    Select Folder Checkbox    ${node}

    Run Keyword If    '${folder}'!='All'    Click Element    xpath=//span[text()='${node}']/preceding-sibling::span[contains(@class, 'rct-checkbox')]

    Sleep    1s
    Capture Page Screenshot
    Close Browser

Expand Folder
    [Arguments]    ${folder}
    Click Element    xpath=//span[text()='${folder}']/ancestor::li/button[@title='Toggle']
    Sleep    0.5s

Select Folder Checkbox
    [Arguments]    ${folder}
    Click Element    xpath=//span[text()='${folder}']/preceding-sibling::span[contains(@class, 'rct-checkbox')]
