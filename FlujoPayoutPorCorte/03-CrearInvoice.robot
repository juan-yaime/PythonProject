*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    SeleniumLibrary
Library    String
Library    DatabaseLibrary
Library    OperatingSystem
Library    Collections
Library    ExcelLibrary


# Configurar PYTHONPATH
Suite Setup    Set Environment Variable    PYTHONPATH    ${CURDIR}

*** Variables ***
${URL}    https://q2-api.kashio-dev.net
${ENDPOINT}    /kpayout/v1/payout_process/api/acc_q2_4nk3zTWhRHHQewLuaQDpKi
${AUTHORIZATION}    Basic YXBpLXNlcnZpY2VzLWF1dGgta2V5OldPMjk2RjUwM0JBSTQwMFQ2MTRBRUw3NzBBOTM0VUpJNTA2RTE3MFo=


#variables de conexion a la bd
${DB_HOST}      kashio-qa-02062023.cgq3qqvhlso3.us-east-1.rds.amazonaws.com
${DB_USER}      juan.yaime
${DB_PASSWORD}  QoqL9jB.nZ2c=<nFiwhL
${DB_NAME}      KashioCore
${DB_PORT}      3306




#Variable a modificar (nombre del archivo de tesoreria que se genera)
${XLS_FILE}     C:\\Users\\USUARIO\\Downloads\\PAYOUT 1730_TESORERIA.xls
${GLOBAL_PATH_PARAM}



#Variable a modificar del flujo de tesoreria(Archivo de tesoreria a importar)
${FILE_PATH_TESO}           C:\\Users\\USUARIO\\Downloads\\PAYOUT 1730_TESORERIA.xls
${OPERATION_NUMBER}       983657554




${URL_BROWSER}                 https://q2-kcms.kashio-dev.net/
${BROWSER}             Chrome

${USER}                juan.Q2.PAYOUT.08042023-2573@kashio.net
${PASSWORD}            Kashio2020+


${USER_TESO}                juan.Q2.PAYOUT.08232023-1374@kashio.net
${PASSWORD_TESO}            Kashio2020+
${LOGIN_BUTTON_ID}     login-submit-button
${NAV_TITLE_CLASS}     nav-title
${NAV_TITLE_TEXT}      Pagos Masivos
${HOME_WAIT_TIME}      10s
${PAYOUT_LINK_HREF}    /payout_process/list
${IMPORT_BUTTON_XPATH}    /html/body/app-root/div/div/payoutprocesslist/div[2]/div/header/div/div/div[2]/div[2]/button
${SELECT_ELEMENT_XPATH}    /html/body/app-root/div/div/app-payoutprocess-import/div[2]/div/app-old-payout-import-version/div/div/div/div/div[2]/div/div[1]/div[2]/select
${OPTION_2_XPATH}      /html/body/app-root/div/div/app-payoutprocess-import/div[2]/div/app-old-payout-import-version/div/div/div/div/div[2]/div/div[1]/div[2]/select/option[2]
${INPUT_FIELD_XPATH}   /html/body/app-root/div/div/app-payoutprocess-import/div[2]/div/app-old-payout-import-version/div/div/div/div/div[2]/div/div[2]/div[2]/form/input
${NEXT_BUTTON_XPATH}   /html/body/app-root/div/div/app-payoutprocess-import/div[2]/div/app-old-payout-import-version/div/div/div/div/div[2]/div/button
${SECOND_NEXT_BUTTON_XPATH}   /html/body/app-root/div/div/app-payoutprocess-import/div[2]/div/app-old-payout-import-version/div/div/div/div/div[2]/div/div/button[2]
${THIRD_NEXT_BUTTON_XPATH}   /html/body/app-root/div/div/app-payoutprocess-import/div[2]/div/app-old-payout-import-version/div/div/div/div/div[2]/div/div/button[1]
${APPROVE_BUTTON_XPATH}   /html/body/app-root/div/div/payoutprocessview/div[2]/div/header/div/div/div[2]/div[2]/button
${FINAL_CONFIRM_BUTTON_XPATH}   //button[@class='btn btn-outline-primary' and @data-toggle='modal' and contains(text(), 'Confirmar')]
${OPERATION_NUMBER_XPATH}    /html/body/app-root/div/div/payoutprocessview/div[2]/div/div/div[6]/div/div/div[2]/div/form/div[2]/div/input
${OPERATION_NUMBER_XPATH_2}    /html/body/app-root/div/div/payoutprocessview/div[2]/div/div/div[6]/div/div/div[2]/div/form/div[3]/div/input
${OPERATION_NUMBER_XPATH_3}    /html/body/app-root/div/div/payoutprocessview/div[2]/div/div/div[6]/div/div/div[2]/div/form/div[4]/div/input
${OPERATION_NUMBER}       98359
${INPUT_FIELD_XPATH_2}    /html/body/app-root/div/div/payoutprocessview/div[2]/div/div/div[6]/div/div/div[2]/div/div/div[2]/input
${FILE_PATH_2}    C:\\Users\\USUARIO\\Downloads\\Archivo_Cualquiera.xlsx
${ENGRAVE_BUTTON_XPATH}    /html/body/app-root/div/div/payoutprocessview/div[2]/div/div/div[6]/div/div/div[3]/button[1]
${TRADE_LIST}    /html/body/app-root/div/div/payoutprocessview/div[2]/app-snav-menu-controller/app-old-snav-menu/aside/div/nav/ul/div/li[4]/ul/li[2]/a
${MOBILE_DATA_TEXT}    PAYOUT
${BTN_CONFIRM}    /html/body/app-root/div/div/app-payoutprocesscommerceview/div[2]/div/header/div/div/div[2]/div/button
${ACCEPT_FROM_MODAL}    /html/body/modal-container/div/div/div[3]/a/span
${OPERATION_NUMBER_XPATH_4}    /html/body/app-root/div/div/app-payoutprocesscommerceconfirm/div[2]/div/div/div/div/div/div/div/div[2]/form/div[1]/div/div/div[1]/input[3]
${BTN_CONFIRM_PROCCES}    /html/body/app-root/div/div/app-payoutprocesscommerceconfirm/div[2]/div/div/div/div/div/div/div/div[2]/form/div[2]/button


*** Keywords ***
Crear Payout
    [Arguments]    ${url}    ${headers}
    ${response}=    POST On Session    ${url}    ${headers}
    [Return]    ${response}



Abrir Página de Login
    Open Browser    ${URL_BROWSER}    ${BROWSER}
    Maximize Browser Window
    Wait Until Page Contains    Login    timeout=20s

Ingresar Credenciales
    [Arguments]    ${USER}    ${password}
    Wait Until Element Is Visible    id=email-input    timeout=10s
    Input Text    id=email-input    ${USER}
    Input Text    id=password-input    ${password}

Hacer Clic en Login
    Wait Until Element Is Visible    id=${LOGIN_BUTTON_ID}    timeout=10s
    Click Button    id=${LOGIN_BUTTON_ID}

Esperar a que Cargue el Home
    Sleep    ${HOME_WAIT_TIME}

Esperar a que Cargue la Página
    Wait Until Page Contains    Pagos    timeout=10s

Hacer Clic en Pagos Masivos
    Wait Until Element Is Visible    xpath=//span[@class='${NAV_TITLE_CLASS}' and text()='${NAV_TITLE_TEXT}']    timeout=10s
    Click Element    xpath=//span[@class='${NAV_TITLE_CLASS}' and text()='${NAV_TITLE_TEXT}']

Hacer Clic en Enlace de Pagos (Lista)
    Wait Until Element Is Visible    xpath=//a[@href='${PAYOUT_LINK_HREF}' and contains(text(), 'Lista')]    timeout=10s
    Click Element    xpath=//a[@href='${PAYOUT_LINK_HREF}' and contains(text(), 'Lista')]



Hacer Clic en Primer Elemento Mobile Data
    [Documentation]    Hace clic en el elemento <span> en el full XPath especificado que contiene el texto 'PAYOUT'.
    Sleep    5s
    Wait Until Element Is Visible    xpath=/html/body/app-root/div/div/payoutprocesslist/div[2]/div/div[1]/div/div/div[2]/div[2]/div/mat-table/mat-row[1]/mat-cell[3]/div/a/span[contains(text(), 'PAYOUT')]    timeout=10s
    Click Element    xpath=/html/body/app-root/div/div/payoutprocesslist/div[2]/div/div[1]/div/div/div[2]/div[2]/div/mat-table/mat-row[1]/mat-cell[3]/div/a/span[contains(text(), 'PAYOUT')]


Mantener Ventana Abierta
    Sleep    15s



Extraer Path Param de URL Dinámica
    [Documentation]    Extrae el path param de la URL actual después de navegar a la página de detalle.
    Sleep    5s
    ${url}=    Get Location
    ${path_parts}=    Split String    ${url}    /
    ${last_segment}=    Set Variable    ${path_parts[-2]}
    Set Global Variable    ${GLOBAL_PATH_PARAM}    ${last_segment}
    Log To Console    Path param extraído: ${GLOBAL_PATH_PARAM}




#Exportacion del archivo de tesoreria

Exportar a XLS
    [Arguments]    ${data}
    # Crear un nuevo archivo Excel
    Create Excel Document    ${XLS_FILE}

    # Escribir los encabezados en la primera fila
    ${header}    Create List    ID CLIENTE    DOCUMENTO    NUMERO DOCUMENTO    NOMBRE    EMAIL    TELEFONO    ESTADO    ID ORDEN DE PAGO    REFERENCIA    NOMBRE ORDEN    DESCRIPCION    MONEDA    MONTO    VENCIMIENTO    EXPIRACION    CODIGO BANCO    CUENTA    TIPO DE CUENTA    CCI
    Write Excel Row    1    ${header}

    # Escribir los datos en las filas siguientes
    ${row_index}    Set Variable    2
    FOR    ${row}    IN    @{data}
        Write Excel Row    ${row_index}    ${row}
        ${row_index}    Evaluate    ${row_index} + 1
    END

    # Guardar y cerrar el archivo Excel
    Save Excel Document    ${XLS_FILE}

    Log    Archivo XLS creado en: ${XLS_FILE}




#Flujo de tesoreria

Abrir Página de Login Teso
    sleep    20s
    Open Browser    ${URL_BROWSER}    ${BROWSER}
    Maximize Browser Window
    Wait Until Page Contains    Login    timeout=20s

Ingresar Credenciales Teso
    [Arguments]    ${username}    ${password}
    Wait Until Element Is Visible    id=email-input    timeout=10s
    Input Text    id=email-input    ${username}
    Input Text    id=password-input    ${password}

Hacer Clic en Login Teso
    Wait Until Element Is Visible    id=${LOGIN_BUTTON_ID}    timeout=10s
    Click Button    id=${LOGIN_BUTTON_ID}

Esperar a que Cargue el Home Teso
    Sleep    ${HOME_WAIT_TIME}

Hacer Clic en Pagos Masivos Teso
    Wait Until Element Is Visible    xpath=//span[@class='${NAV_TITLE_CLASS}' and text()='${NAV_TITLE_TEXT}']    timeout=10s
    Click Element    xpath=//span[@class='${NAV_TITLE_CLASS}' and text()='${NAV_TITLE_TEXT}']

Esperar a que Cargue la Página de Pagos Teso
    Wait Until Page Contains    Pagos    timeout=10s

Hacer Clic en Enlace de Pagos (Lista) Teso
    Wait Until Element Is Visible    xpath=//a[@href='${PAYOUT_LINK_HREF}' and contains(text(), 'Lista')]    timeout=10s
    Click Element    xpath=//a[@href='${PAYOUT_LINK_HREF}' and contains(text(), 'Lista')]

Hacer Clic en Botón Importar Teso
    Wait Until Element Is Visible    xpath=${IMPORT_BUTTON_XPATH}    timeout=10s
    Click Element    xpath=${IMPORT_BUTTON_XPATH}

Hacer Clic en Seleccione Teso
    Wait Until Element Is Visible    xpath=${SELECT_ELEMENT_XPATH}    timeout=10s
    Click Element    xpath=${SELECT_ELEMENT_XPATH}

Seleccionar Opcion 2 Teso
    Wait Until Element Is Visible    xpath=${OPTION_2_XPATH}    timeout=10s
    Click Element    xpath=${OPTION_2_XPATH}

Cargar Archivo Teso
    Sleep    6s
    [Documentation]    Carga el archivo especificado en el campo de entrada de archivo.
    Input Text    xpath=${INPUT_FIELD_XPATH}    ${FILE_PATH_TESO}

Hacer Clic en Próximo Teso
    Sleep    3s
    Wait Until Element Is Visible    xpath=${NEXT_BUTTON_XPATH}    timeout=10s
    Click Element    xpath=${NEXT_BUTTON_XPATH}

Hacer Clic en Botón Confirmar Teso
    Sleep    6s
    Wait Until Element Is Visible    xpath=${SECOND_NEXT_BUTTON_XPATH}    timeout=10s
    Click Element    xpath=${SECOND_NEXT_BUTTON_XPATH}

Hacer Clic en Botón Detalle de Pago Teso
    sleep    8S
    Wait Until Element Is Visible    xpath=${THIRD_NEXT_BUTTON_XPATH}    timeout=10s
    Click Element    xpath=${THIRD_NEXT_BUTTON_XPATH}

Clic en Aprobar Tesorería Teso
    [Documentation]    Espera 4 segundos y luego hace clic en el botón de aprobar.
    Sleep    10s
    Wait Until Element Is Visible    xpath=${APPROVE_BUTTON_XPATH}    timeout=10s
    Click Element    xpath=${APPROVE_BUTTON_XPATH}

Clic en Botón Confirmar Final Teso
    [Documentation]    Hace clic en el botón de confirmar que aparece después de aprobar tesorería.
    Sleep    5s
    Wait Until Element Is Visible    xpath=${FINAL_CONFIRM_BUTTON_XPATH}    timeout=10s
    Click Element    xpath=${FINAL_CONFIRM_BUTTON_XPATH}

Ingresar Número de Operación Teso
    [Documentation]    Ingresa un número de operación de 5 dígitos en el campo correspondiente.
    Sleep    5s
    Wait Until Element Is Visible    xpath=${OPERATION_NUMBER_XPATH}    timeout=10s
    Input Text    xpath=${OPERATION_NUMBER_XPATH}    ${OPERATION_NUMBER}
    Input Text    xpath=${OPERATION_NUMBER_XPATH_2}    ${OPERATION_NUMBER}
    Input Text    xpath=${OPERATION_NUMBER_XPATH_3}    ${OPERATION_NUMBER}

Cargar archivo xls cualquiera Teso
    [Documentation]    Carga el archivo especificado en el campo de entrada de archivo del modal de confirmacion.
    Sleep    5s
    Input Text    xpath=${INPUT_FIELD_XPATH_2}    ${FILE_PATH_2}


Clic En Boton Grabar Modal Teso
    [Documentation]    Espera 3 segundos y luego hace clic en el botón de grabar.
    Sleep    5s
    Wait Until Element Is Visible    xpath=${ENGRAVE_BUTTON_XPATH}    timeout=10s
    Click Element    xpath=${ENGRAVE_BUTTON_XPATH}


Sleep de 30 segundos Teso
    sleep    35s


Hacer Clic en Lista Comercio Teso
    [Documentation]    Hace clic en lista comercio para confirmar el payout.
    Sleep    5s
    Wait Until Element Is Visible    xpath=${TRADE_LIST}    timeout=10s
    Click Element    xpath=${TRADE_LIST}


Hacer Clic en Primer Elemento Mobile Data Teso
    [Documentation]    Hace clic en el primer <span> con la clase 'mobile-data' que contiene el texto 'PAYOUT'.
    sleep    5s
    Wait Until Element Is Visible    xpath=(//span[@class='mobile-data' and contains(text(), 'PAYOUT')])[1]    timeout=10s
    Click Element    xpath=(//span[@class='mobile-data' and contains(text(), 'PAYOUT')])[1]


Hacer Clic en btn Confirmar (Lista comercio) Teso
    sleep    5s
    Wait Until Element Is Visible    xpath=${BTN_CONFIRM}   timeout=10s
    Click Element    xpath=${BTN_CONFIRM}

Hacer clic btn Aceptar(Modal) Teso
    sleep    5s
    Wait Until Element Is Visible    xpath=${ACCEPT_FROM_MODAL}  timeout=10s
    Click Element    xpath=${ACCEPT_FROM_MODAL}


Ingresar Numero de Operacion Teso
    sleep    5s
    Wait Until Element Is Visible    xpath=${OPERATION_NUMBER_XPATH_4}    timeout=10s
    Input Text    xpath=${OPERATION_NUMBER_XPATH_4}    ${OPERATION_NUMBER}


Clic en Confirmar(Proceso de confirmacion) Teso
    sleep    5s
    Wait Until Element Is Visible    xpath=${BTN_CONFIRM_PROCCES}  timeout=10s
    Click Element    xpath=${BTN_CONFIRM_PROCCES}


Mantener Ventana Abierta Teso
    Sleep    20s

Cerrar Navegador Teso
    Close Browser



*** Test Cases ***
Crear Payout
    # Crear sesión con la URL base
    Create Session    mysession    ${URL}

    # Crear encabezados
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=${AUTHORIZATION}

    # Realizar la solicitud POST usando la sesión creada
    ${response}=    POST On Session    mysession    ${ENDPOINT}    headers=${headers}

    # Verificar el código de estado de la respuesta
    Should Be True    ${response.status_code} == 200 or ${response.status_code} == 201
    Log    Respuesta: ${response.text}


Iniciar sesión para extraer path param
    [Documentation]    Flujo completo de login, navegación y confirmación de un payout.
    Abrir Página de Login
    Ingresar Credenciales    ${USER}    ${PASSWORD}
    Hacer Clic en Login
    Esperar a que Cargue el Home
    Hacer Clic en Pagos Masivos
    Esperar a que Cargue la Página
    Hacer Clic en Enlace de Pagos (Lista)
    Hacer Clic en Primer Elemento Mobile Data
    Extraer Path Param de URL Dinámica
    Mantener Ventana Abierta


Conectar a la base de datos y ejecutar consulta compleja
    # Conectar a la base de datos
    Connect To Database    pymysql    ${DB_NAME}    ${DB_USER}    ${DB_PASSWORD}    ${DB_HOST}    ${DB_PORT}

Ejecutar consulta SQL
    ${set_query}    Set Variable
    ...    SET @ProcessID = (SELECT process_id FROM Process WHERE public_id = '${GLOBAL_PATH_PARAM}');

    ${select_query}    Set Variable
    ...    SELECT deb.document_number AS 'ID CLIENTE', CASE WHEN deb.document_type_id = 1 THEN 'DNI' WHEN deb.document_type_id = 3 THEN 'RUC' ELSE 'DNI' END AS 'DOCUMENTO', deb.document_number AS 'NUMERO DOCUMENTO', deb.name AS 'NOMBRE', 'email@pruebas.com' AS 'EMAIL', deb.phone_number AS 'TELEFONO', 'ACTIVO' AS 'ESTADO', inv.psp_tin AS 'ID ORDEN DE PAGO', inv.psp_tin AS 'REFERENCIA', inv.psp_tin AS 'NOMBRE ORDEN', inv.psp_tin AS 'DESCRIPCION', inv.currency_code AS 'MONEDA', ROUND(inv.amount, 2) AS 'MONTO', '31/12/2022' AS 'VENCIMIENTO', '31/12/2022' AS 'EXPIRACION', CASE WHEN bank.external_id = '001' THEN '1' WHEN bank.external_id = '002' THEN '2' WHEN bank.external_id = '003' THEN '3' WHEN bank.external_id = '004' THEN '4' ELSE '000' END AS 'CODIGO BANCO', acc.account_number AS 'CUENTA', CASE WHEN acc.metadata->>'$.type' = 'SAVING' THEN 'AHORRO' ELSE 'CORRIENTE' END AS 'TIPO DE CUENTA', acc.metadata->>'$.cci' AS 'CCI' FROM Customer cus JOIN Process proc ON proc.customer_id = cus.customer_id JOIN Payout_Process pyo ON pyo.payout_process_id = proc.process_id JOIN ProcessStatus proc_s2 ON proc_s2.process_status_id = proc.process_status_id AND proc_s2.process_type_id = 10 JOIN Payout_Process_Items ppi ON ppi.payout_process_id = pyo.payout_process_id JOIN Account acc_pyo ON acc_pyo.account_id = pyo.account_id JOIN Invoice inv ON ppi.resource_id = inv.invoice_id AND inv.create_date > '2023-04-01 15:45:15' JOIN Debtor deb ON deb.debtor_id = inv.debtor_id JOIN Customer deb_cus ON deb.customer_id = deb_cus.customer_id JOIN Account acc ON acc.customer_id = deb_cus.customer_id AND acc.public_id = CONVERT(inv.order_detail->>'$.metadata.accounts[0].id' USING utf8) JOIN Bank bank ON bank.bank_id = acc.bank_id JOIN ProcessStatus proc_s1 ON proc_s1.process_status_id = inv.status AND proc_s1.process_type_id = 1 LEFT JOIN Payout po ON ppi.payout_id = po.payout_id LEFT JOIN Transaction tr ON po.payout_id = tr.transaction_id LEFT JOIN Configuration cnf ON cnf.customer_id = cus.customer_id AND cnf.key = 'payouts_services.configuration' WHERE cus.customer_type_id = 104 AND pyo.payout_process_id = @ProcessID AND inv.status = 3;

    # Ejecutar la consulta
    Execute SQL String    ${set_query}

    ${result}    Query    ${select_query}
    Log    ${result}

    Run Keyword If    ${result}    Exportar a XLS    ${result}
    ...    ELSE    Log    No se encontraron registros para exportar.



Iniciar sesión
    Abrir Página de Login Teso
    Ingresar Credenciales Teso    ${USER_TESO}    ${PASSWORD_TESO}
    Hacer Clic en Login Teso
    Esperar a que Cargue el Home Teso
    Hacer Clic en Pagos Masivos Teso
    Esperar a que Cargue la Página de Pagos Teso
    Hacer Clic en Enlace de Pagos (Lista) Teso
    Hacer Clic en Botón Importar Teso
    Hacer Clic en Seleccione Teso
    Seleccionar Opcion 2 Teso
    Cargar Archivo Teso
    Hacer Clic en Próximo Teso
    Hacer Clic en Botón Confirmar Teso
    Hacer Clic en Botón Detalle de Pago Teso
    Clic en Aprobar Tesorería Teso
    Clic en Botón Confirmar Final Teso
    Ingresar Número de Operación Teso
    Cargar archivo xls cualquiera Teso
    Clic En Boton Grabar Modal Teso
    Sleep de 30 segundos Teso
    Hacer Clic en Pagos Masivos Teso
    Hacer Clic en Lista Comercio Teso
    Hacer Clic en Primer Elemento Mobile Data Teso
    Hacer Clic en btn Confirmar (Lista comercio) Teso
    Hacer clic btn Aceptar(Modal) Teso
    Ingresar Numero de Operacion Teso
    Clic en Confirmar(Proceso de confirmacion) Teso
    Mantener Ventana Abierta Teso
    Cerrar Navegador Teso