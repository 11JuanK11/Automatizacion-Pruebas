*** Settings ***
Library           SeleniumLibrary
Library           DataDriver    students.csv    delimiter=;
Library           ScreenCapLibrary
Library           AutoRecorder
Suite Setup       Start Suite Recording
Suite Teardown    Stop Suite Recording
Test Template     Submit Practice Form
Test Teardown     Capture Page Screenshot

*** Variables ***
${URL}            https://demoqa.com/automation-practice-form
${BROWSER}        chrome
${UPLOAD_PIC}     ${CURDIR}${/}resources${/}photo.png

*** Test Cases ***
Submit Practice Form

*** Keywords ***
Start Suite Recording
    Start Video Recording
Stop Suite Recording
    Stop Video Recording

Submit Practice Form
    [Arguments]    ${first}    ${last}    ${email}    ${gender}    ${mobile}    ${day}  ${month}  ${year}    ${subject}    ${hobby}    ${state}    ${city}
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Sleep    2s
    Input Text    xpath=/html/body/div[2]/div/div/div/div[2]/div[2]/form/div[1]/div[2]/input    ${first}
    Sleep    1s
    Input Text    xpath=/html/body/div[2]/div/div/div/div[2]/div[2]/form/div[1]/div[4]/input    ${last}
    Sleep    1s
    Input Text    xpath=/html/body/div[2]/div/div/div/div[2]/div[2]/form/div[2]/div[2]/input    ${email}
    Sleep    1s
    Click Element    xpath=//label[text()='${gender}']
    Sleep    1s
    Input Text    xpath=/html/body/div[2]/div/div/div/div[2]/div[2]/form/div[4]/div[2]/input   ${mobile}
    Sleep    1s
    Click Element    xpath=//label[text()='${hobby}']
    Sleep    1s
    Choose File    xpath=/html/body/div[2]/div/div/div/div[2]/div[2]/form/div[8]/div[2]/div/input    ${UPLOAD_PIC}
    Sleep    1s
    Input Text    xpath=/html/body/div[2]/div/div/div/div[2]/div[2]/form/div[9]/div[2]/textarea   Avenida Siempre Viva 123
    Sleep    1s
    Click Element    xpath=/html/body/div[2]/div/div/div/div[2]/div[2]/form/div[10]/div[2]/div/div/div[1]/div[1]
    Click Element    xpath=//div[text()='${state}']
    Sleep    1s
    Click Element    xpath=/html/body/div[2]/div/div/div/div[2]/div[2]/form/div[10]/div[3]/div/div/div[1]/div[1]
    Click Element    xpath=//div[text()='${city}']
    Sleep    1s
    Click Button    xpath=/html/body/div[2]/div/div/div/div[2]/div[2]/form/div[11]/div/button
    Sleep    3s
    Wait Until Element Is Visible    //div[@id='example-modal-sizes-title-lg']
    Close Browser
