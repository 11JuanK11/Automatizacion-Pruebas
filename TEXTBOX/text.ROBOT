*** Settings ***
Library    SeleniumLibrary
Library    ScreenCapLibrary
Library    AutoRecorder

Test Setup       Start Video Recording
Test Teardown    Stop Video Recording

*** Variables ***
${URL}         https://demoqa.com/automation-practice-form
${BROWSER}     chrome

*** Test Cases ***
Automatizar Desplegable y Campos de Texto
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Sleep    2s

    # Paso 1: Click en el desplegable
    Click Element    xpath=/html/body/div[2]/div/div/div/div[1]/div/div/div[1]/span/div/div[2]
    Sleep    1s

    # Paso 2: Selección de primer elemento
    Click Element    xpath=/html/body/div[2]/div/div/div/div[1]/div/div/div[1]/div/ul/li[1]
    Sleep    1s

    # Paso 3: Llenado de campos tipo texto
    Input Text    xpath=/html/body/div[2]/div/div/div/div[2]/div[2]/form/div[1]/div[2]/input    Juan
    Input Text    xpath=/html/body/div[2]/div/div/div/div[2]/div[2]/form/div[2]/div[2]/input    juan@email.com
    Input Text    xpath=/html/body/div[2]/div/div/div/div[2]/div[2]/form/div[3]/div[2]/textarea    Calle Falsa 123
    Input Text    xpath=/html/body/div[2]/div/div/div/div[2]/div[2]/form/div[4]/div[2]/textarea    Otra dirección

    Capture Page Screenshot
    Sleep    2s
    Close Browser
