*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}                 https://q2-kcms.kashio-dev.net/
${BROWSER}             Chrome
${USER}                juan.Q2.PAYOUT.08232023-1374@kashio.net
${PASSWORD}            Kashio2020+
${LOGIN_BUTTON_ID}     login-submit-button
${NAV_TITLE_CLASS}     nav-title
${NAV_TITLE_TEXT}      Pagos Masivos
${HOME_WAIT_TIME}      10s
${PAYOUT_LINK_HREF}    /payout_process/list
${IMPORT_BUTTON_XPATH}    /html/body/app-root/div/div/payoutprocesslist/div[2]/div/header/div/div/div[2]/div[2]/button
${SELECT_ELEMENT_XPATH}    /html/body/app-root/div/div/app-payoutprocess-import/div[2]/div/app-old-payout-import-version/div/div/div/div/div[2]/div/div[1]/div[2]/select
${OPTION_2_XPATH}      /html/body/app-root/div/div/app-payoutprocess-import/div[2]/div/app-old-payout-import-version/div/div/div/div/div[2]/div/div[1]/div[2]/select/option[2]
${INPUT_FIELD_XPATH}   /html/body/app-root/div/div/app-payoutprocess-import/div[2]/div/app-old-payout-import-version/div/div/div/div/div[2]/div/div[2]/div[2]/form/input

${FILE_PATH}           C:\\Users\\USUARIO\\Downloads\\PAYOUT 1050_TESORERIA.xls


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
Abrir Página de Login
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Page Contains    Login    timeout=20s

Ingresar Credenciales
    [Arguments]    ${username}    ${password}
    Wait Until Element Is Visible    id=email-input    timeout=10s
    Input Text    id=email-input    ${username}
    Input Text    id=password-input    ${password}

Hacer Clic en Login
    Wait Until Element Is Visible    id=${LOGIN_BUTTON_ID}    timeout=10s
    Click Button    id=${LOGIN_BUTTON_ID}

Esperar a que Cargue el Home
    Sleep    ${HOME_WAIT_TIME}

Hacer Clic en Pagos Masivos
    Wait Until Element Is Visible    xpath=//span[@class='${NAV_TITLE_CLASS}' and text()='${NAV_TITLE_TEXT}']    timeout=10s
    Click Element    xpath=//span[@class='${NAV_TITLE_CLASS}' and text()='${NAV_TITLE_TEXT}']

Esperar a que Cargue la Página de Pagos
    Wait Until Page Contains    Pagos    timeout=10s

Hacer Clic en Enlace de Pagos (Lista)
    Wait Until Element Is Visible    xpath=//a[@href='${PAYOUT_LINK_HREF}' and contains(text(), 'Lista')]    timeout=10s
    Click Element    xpath=//a[@href='${PAYOUT_LINK_HREF}' and contains(text(), 'Lista')]

Hacer Clic en Botón Importar
    Wait Until Element Is Visible    xpath=${IMPORT_BUTTON_XPATH}    timeout=10s
    Click Element    xpath=${IMPORT_BUTTON_XPATH}

Hacer Clic en Seleccione
    Wait Until Element Is Visible    xpath=${SELECT_ELEMENT_XPATH}    timeout=10s
    Click Element    xpath=${SELECT_ELEMENT_XPATH}

Seleccionar Opcion 2
    Wait Until Element Is Visible    xpath=${OPTION_2_XPATH}    timeout=10s
    Click Element    xpath=${OPTION_2_XPATH}

Cargar Archivo
    Sleep    6s
    [Documentation]    Carga el archivo especificado en el campo de entrada de archivo.
    Input Text    xpath=${INPUT_FIELD_XPATH}    ${FILE_PATH}

Hacer Clic en Próximo
    Sleep    3s
    Wait Until Element Is Visible    xpath=${NEXT_BUTTON_XPATH}    timeout=10s
    Click Element    xpath=${NEXT_BUTTON_XPATH}

Sleep de 6 Segundos
    Sleep    6s

Hacer Clic en Botón Confirmar
    Wait Until Element Is Visible    xpath=${SECOND_NEXT_BUTTON_XPATH}    timeout=10s
    Click Element    xpath=${SECOND_NEXT_BUTTON_XPATH}

Sleep de 5 Segundos
    Sleep    5s

Hacer Clic en Botón Detalle de Pago
    sleep    3S
    Wait Until Element Is Visible    xpath=${THIRD_NEXT_BUTTON_XPATH}    timeout=10s
    Click Element    xpath=${THIRD_NEXT_BUTTON_XPATH}

Clic en Aprobar Tesorería
    [Documentation]    Espera 4 segundos y luego hace clic en el botón de aprobar.
    Sleep    10s
    Wait Until Element Is Visible    xpath=${APPROVE_BUTTON_XPATH}    timeout=10s
    Click Element    xpath=${APPROVE_BUTTON_XPATH}

Clic en Botón Confirmar Final
    [Documentation]    Hace clic en el botón de confirmar que aparece después de aprobar tesorería.
    Sleep    5s
    Wait Until Element Is Visible    xpath=${FINAL_CONFIRM_BUTTON_XPATH}    timeout=10s
    Click Element    xpath=${FINAL_CONFIRM_BUTTON_XPATH}

Ingresar Número de Operación
    [Documentation]    Ingresa un número de operación de 5 dígitos en el campo correspondiente.
    Sleep    5s
    Wait Until Element Is Visible    xpath=${OPERATION_NUMBER_XPATH}    timeout=10s
    Input Text    xpath=${OPERATION_NUMBER_XPATH}    ${OPERATION_NUMBER}
    Input Text    xpath=${OPERATION_NUMBER_XPATH_2}    ${OPERATION_NUMBER}
    Input Text    xpath=${OPERATION_NUMBER_XPATH_3}    ${OPERATION_NUMBER}

Cargar archivo xls cualquiera
    [Documentation]    Carga el archivo especificado en el campo de entrada de archivo del modal de confirmacion.
    Sleep    5s
    Input Text    xpath=${INPUT_FIELD_XPATH_2}    ${FILE_PATH_2}


Clic En Boton Grabar Modal
    [Documentation]    Espera 3 segundos y luego hace clic en el botón de grabar.
    Sleep    5s
    Wait Until Element Is Visible    xpath=${ENGRAVE_BUTTON_XPATH}    timeout=10s
    Click Element    xpath=${ENGRAVE_BUTTON_XPATH}


Sleep de 30 segundos
    sleep    35s


Hacer Clic en Lista Comercio
    [Documentation]    Hace clic en lista comercio para confirmar el payout.
    Sleep    5s
    Wait Until Element Is Visible    xpath=${TRADE_LIST}    timeout=10s
    Click Element    xpath=${TRADE_LIST}


Hacer Clic en Primer Elemento Mobile Data
    [Documentation]    Hace clic en el primer <span> con la clase 'mobile-data' que contiene el texto 'PAYOUT'.
    sleep    5s
    Wait Until Element Is Visible    xpath=(//span[@class='mobile-data' and contains(text(), 'PAYOUT')])[1]    timeout=10s
    Click Element    xpath=(//span[@class='mobile-data' and contains(text(), 'PAYOUT')])[1]


Hacer Clic en btn Confirmar (Lista comercio)
    sleep    5s
    Wait Until Element Is Visible    xpath=${BTN_CONFIRM}   timeout=10s
    Click Element    xpath=${BTN_CONFIRM}

Hacer clic btn Aceptar(Modal)
    sleep    5s
    Wait Until Element Is Visible    xpath=${ACCEPT_FROM_MODAL}  timeout=10s
    Click Element    xpath=${ACCEPT_FROM_MODAL}


Ingresar Numero de Operacion
    sleep    5s
    Wait Until Element Is Visible    xpath=${OPERATION_NUMBER_XPATH_4}    timeout=10s
    Input Text    xpath=${OPERATION_NUMBER_XPATH_4}    ${OPERATION_NUMBER}


Clic en Confirmar(Proceso de confirmacion)
    sleep    5s
    Wait Until Element Is Visible    xpath=${BTN_CONFIRM_PROCCES}  timeout=10s
    Click Element    xpath=${BTN_CONFIRM_PROCCES}

Mantener Ventana Abierta
    Sleep    20s

Cerrar Navegador
    Close Browser

*** Test Cases ***
Iniciar sesión, cargar archivo, y realizar proceso completo
    Abrir Página de Login
    Ingresar Credenciales    ${USER}    ${PASSWORD}
    Hacer Clic en Login
    Esperar a que Cargue el Home
    Hacer Clic en Pagos Masivos
    Esperar a que Cargue la Página de Pagos
    Hacer Clic en Enlace de Pagos (Lista)
    Hacer Clic en Botón Importar
    Hacer Clic en Seleccione
    Seleccionar Opcion 2
    Cargar Archivo
    Hacer Clic en Próximo
    Sleep de 6 Segundos
    Hacer Clic en Botón Confirmar
    Sleep de 5 Segundos
    Hacer Clic en Botón Detalle de Pago
    Clic en Aprobar Tesorería
    Clic en Botón Confirmar Final
    Ingresar Número de Operación
    Cargar archivo xls cualquiera
    Clic En Boton Grabar Modal
    Sleep de 30 segundos
    Hacer Clic en Pagos Masivos
    Hacer Clic en Lista Comercio
    Hacer Clic en Primer Elemento Mobile Data
    Hacer Clic en btn Confirmar (Lista comercio)
    Hacer clic btn Aceptar(Modal)
    Ingresar Numero de Operacion
    Clic en Confirmar(Proceso de confirmacion)
    Mantener Ventana Abierta
    Cerrar Navegador
