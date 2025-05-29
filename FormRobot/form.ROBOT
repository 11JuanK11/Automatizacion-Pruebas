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

Fill Date Of Birth    ${day}    ${month}    ${year}
    Click Element    /html/body/div[1]/div/div/div[2]/div[2]/form/div[5]/div[2]/div[1]/input
    Select From List By Value    /html/body/div[2]/div/div[2]/div/div/select[1]    ${month}
    Select From List By Value    /html/body/div[2]/div/div[2]/div/div/select[2]    ${year}
    Click Element    //div[contains(@class,'react-datepicker__day') and normalize-space(text())='${day}']

Submit Practice Form
    [Arguments]    ${first}    ${last}    ${email}    ${gender}    ${mobile}    ${day}    ${month}    ${year}    ${subject}    ${hobby}    ${state}    ${city}
    Open Browser    ${URL}    ${BROWSER}    options=add_argument(--start-maximized)
    Input Text    /html/body/div[2]/div/div/div/div[2]/div[2]/form/div[1]/div[2]/input    ${first}
    Input Text    /html/body/div[2]/div/div/div/div[2]/div[2]/form/div[1]/div[4]/input    ${last}
    Input Text    /html/body/div[2]/div/div/div/div[2]/div[2]/form/div[2]/div[2]/input    ${email}
    Click Element    //label[text()='${gender}']
    Input Text    /html/body/div[2]/div/div/div/div[2]/div[2]/form/div[4]/div[2]/input    ${mobile}
    Fill Date Of Birth    ${day}    ${month}    ${year}
    Input Text    /html/body/div[2]/div/div/div/div[2]/div[2]/form/div[6]/div[2]/div/div/div[1]    ${subject}
    Press Keys    /html/body/div[1]/div/div/div[2]/div[2]/form/div[6]/div[2]/div/div/div[1]/div[1]/input    RETURN
    Click Element    //label[text()='${hobby}']
    Choose File    /html/body/div[1]/div/div/div[2]/div[2]/form/div[8]/div[2]/input    ${UPLOAD_PIC}
    Input Text    /html/body/div[2]/div/div/div/div[2]/div[2]/form/div[9]/div[2]/textarea    Avenida Siempre Viva 123
    Click Element    /html/body/div[1]/div/div/div[2]/div[2]/form/div[10]/div[2]/div/div[1]
    Click Element    //div[text()='${state}']
    Click Element    /html/body/div[1]/div/div/div[2]/div[2]/form/div[10]/div[3]/div/div[1]
    Click Element    //div[text()='${city}']
    Click Button    /html/body/div[1]/div/div/div[2]/div[2]/form/div[11]/div/button
    Wait Until Element Is Visible    //div[@id='example-modal-sizes-title-lg']
    Close Browser
