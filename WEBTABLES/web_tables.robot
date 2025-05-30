*** Settings ***
Documentation    Pruebas de WebTables con DataDriver y Grabación
Library          DataDriver    web_tables_data.csv
Resource         resources/common_keywords.robot
Suite Setup      Iniciar Grabación
Suite Teardown   Detener Grabación
Test Setup       Abrir Navegador y Eliminar Anuncios
Test Teardown    Cerrar Navegador y Video
Test Template    Probar Agregar y Validar Registro

*** Test Cases ***
WebTables Test with ${first_name} ${last_name}

*** Keywords ***
Probar Agregar y Validar Registro
    [Arguments]    ${first_name}    ${last_name}    ${email}    ${age}    ${salary}    ${department}
    
    # Add new record
    Ejecutar Click Seguro    id=addNewRecordButton
    Input Text      id=firstName    ${first_name}
    Input Text      id=lastName     ${last_name}
    Input Text      id=userEmail    ${email}
    Input Text      id=age          ${age}
    Input Text      id=salary       ${salary}
    Input Text      id=department   ${department}
    Ejecutar Click Seguro    id=submit

    # Captura de pantalla después de agregar el registro
    Capture Page Screenshot 

    # Validate record
    ${row_xpath}=    Set Variable    //div[contains(@class, 'rt-tr-group')][.//div[text()='${email}']]
    Wait Until Page Contains Element    ${row_xpath}    20s
    Validate Table Cell    ${row_xpath}    1    ${first_name}
    Validate Table Cell    ${row_xpath}    2    ${last_name}
    Validate Table Cell    ${row_xpath}    3    ${age}
    Validate Table Cell    ${row_xpath}    4    ${email}
    Validate Table Cell    ${row_xpath}    5    ${salary}
    Validate Table Cell    ${row_xpath}    6    ${department}

    # Edit record
    ${edit_xpath}=    Set Variable    ${row_xpath}//span[@title='Edit']
    Ejecutar Click Seguro    ${edit_xpath}
    Input Text       id=department    Edited_${department}
    Ejecutar Click Seguro    id=submit
    
    # Validate edit
    Validate Table Cell    ${row_xpath}    6    Edited_${department}

    # Delete record
    ${delete_xpath}=    Set Variable    ${row_xpath}//span[@title='Delete']
    Ejecutar Click Seguro    ${delete_xpath}
    Wait Until Page Does Not Contain    ${email}    20s

Abrir Navegador y Eliminar Anuncios
    Abrir Navegador a WebTables
    Eliminar Anuncios

Eliminar Anuncios
    Execute JavaScript    window.open('about:blank','_blank').close();
    Execute JavaScript    document.querySelectorAll('iframe, .ad, .ads, [id*="google_ads"]').forEach(e => e.remove());
    Execute JavaScript    document.body.style.zoom = "0.8";

Ejecutar Click Seguro
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}    20s
    ${element}=    Get WebElement    ${locator}
    Execute JavaScript    arguments[0].click();    ARGUMENTS    ${element}

Validate Table Cell
    [Arguments]    ${row_xpath}    ${column}    ${expected}
    ${cell_content}=    Get Text    ${row_xpath}/div/div[${column}]
    Should Be Equal    ${cell_content}    ${expected}