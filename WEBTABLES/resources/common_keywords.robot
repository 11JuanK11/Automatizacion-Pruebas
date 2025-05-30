*** Settings ***
Library    SeleniumLibrary
Library    ScreenCapLibrary

*** Keywords ***
Abrir Navegador a WebTables
    Open Browser    https://demoqa.com/webtables    Chrome
    Maximize Browser Window
    Set Selenium Speed    0.2

Cerrar Navegador y Video
    #Run Keyword If Test Passed    Capture Page Screenshot
    Close All Browsers

Iniciar Grabación
    Start Video Recording    name=WebTablesTest

Detener Grabación
    Stop Video Recording