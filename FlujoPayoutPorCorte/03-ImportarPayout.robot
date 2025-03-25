*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}                 https://q2-kcms.kashio-dev.net/
${BROWSER}             Chrome
${USER}                juan.Q2.PAYOUT.08042023-2573@kashio.net
${PASSWORD}            Kashio2020+
${LOGIN_BUTTON_ID}     login-submit-button
${NAV_TITLE_CLASS}     nav-title
${NAV_TITLE_TEXT}      Pagos Masivos
${HOME_WAIT_TIME}      10s
${PAYOUT_LINK_HREF}    /payout_process/list
${MOBILE_DATA_CLASS}   mobile-data
${MOBILE_DATA_TEXT}    PAYOUT
${PAYOUT_APPROVE_BUTTON_XPATH}  /html/body/app-root/div/div/payoutprocessview/div[2]/div/header/div/div/div[2]/div[2]/button
${IMPORT_BUTTON_XPATH}    /html/body/app-root/div/div/payoutprocesslist/div[2]/div/header/div/div/div[2]/div[2]/button
${SELECT_ELEMENT_XPATH}    /html/body/app-root/div/div/app-payoutprocess-import/div[2]/div/app-old-payout-import-version/div/div/div/div/div[2]/div/div[1]/div[2]/select
${OPTION_2_XPATH}      /html/body/app-root/div/div/app-payoutprocess-import/div[2]/div/app-old-payout-import-version/div/div/div/div/div[2]/div/div[1]/div[2]/select/option[2]
${INPUT_FIELD_XPATH}   /html/body/app-root/div/div/app-payoutprocess-import/div[2]/div/app-old-payout-import-version/div/div/div/div/div[2]/div/div[2]/div[2]/form/input

${FILE_PATH}           C:\\Users\\USUARIO\\OneDrive\\Kashio.net\\KPS-716\\qa-payout-services-1\\PAYOUT 1170.xlsx

${NEXT_BUTTON_XPATH}   /html/body/app-root/div/div/app-payoutprocess-import/div[2]/div/app-old-payout-import-version/div/div/div/div/div[2]/div/button
${SECOND_NEXT_BUTTON_XPATH}   /html/body/app-root/div/div/app-payoutprocess-import/div[2]/div/app-old-payout-import-version/div/div/div/div/div[2]/div/div/button[2]
${THIRD_NEXT_BUTTON_XPATH}   /html/body/app-root/div/div/app-payoutprocess-import/div[2]/div/app-old-payout-import-version/div/div/div/div/div[2]/div/div/button[1]
${APPROVE_BUTTON_XPATH}   /html/body/app-root/div/div/payoutprocessview/div[2]/div/header/div/div/div[2]/div[2]/button

*** Keywords ***
Abrir Página de Login
    [Documentation]    Abre el navegador y navega a la página de login.
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Page Contains    Login    timeout=20s

Ingresar Credenciales
    [Arguments]    ${username}    ${password}
    [Documentation]    Ingresa las credenciales en los campos correspondientes.
    Wait Until Element Is Visible    id=email-input    timeout=10s
    Input Text    id=email-input    ${username}
    Input Text    id=password-input    ${password}

Hacer Clic en Login
    [Documentation]    Hace clic en el botón de iniciar sesión.
    Wait Until Element Is Visible    id=${LOGIN_BUTTON_ID}    timeout=10s
    Click Button    id=${LOGIN_BUTTON_ID}

Esperar a que Cargue el Home
    [Documentation]    Espera 10 segundos para asegurarse de que la página de inicio se haya cargado completamente.
    Sleep    ${HOME_WAIT_TIME}

Esperar a que Cargue la Página
    [Documentation]    Espera a que la página de pagos haya cargado completamente.
    Wait Until Page Contains    Pagos    timeout=10s

Hacer Clic en Pagos Masivos
    [Documentation]    Hace clic en el <span> con la clase 'nav-title' que contiene el texto 'Pagos Masivos'.
    Wait Until Element Is Visible    xpath=//span[@class='${NAV_TITLE_CLASS}' and text()='${NAV_TITLE_TEXT}']    timeout=10s
    Click Element    xpath=//span[@class='${NAV_TITLE_CLASS}' and text()='${NAV_TITLE_TEXT}']


Hacer Clic en Enlace de Pagos (Lista)
    [Documentation]    Hace clic en el enlace <a href="/payout_process/list"> que contiene el texto "Lista".
    Wait Until Element Is Visible    xpath=//a[@href='${PAYOUT_LINK_HREF}' and contains(text(), 'Lista')]    timeout=10s
    Click Element    xpath=//a[@href='${PAYOUT_LINK_HREF}' and contains(text(), 'Lista')]

Hacer Clic en Botón Importar
    sleep   3s
    Wait Until Element Is Visible    xpath=${IMPORT_BUTTON_XPATH}    timeout=10s
    Click Element    xpath=${IMPORT_BUTTON_XPATH}

Hacer Clic en Seleccione
    sleep    3s
    Wait Until Element Is Visible    xpath=${SELECT_ELEMENT_XPATH}    timeout=10s
    Click Element    xpath=${SELECT_ELEMENT_XPATH}

Seleccionar Opcion 2
    sleep    2s
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

Hacer Clic en Botón Confirmar
    Sleep    6s
    Wait Until Element Is Visible    xpath=${SECOND_NEXT_BUTTON_XPATH}    timeout=10s
    Click Element    xpath=${SECOND_NEXT_BUTTON_XPATH}

Hacer Clic en Botón Detalle de Pago
    sleep    5S
    Wait Until Element Is Visible    xpath=${THIRD_NEXT_BUTTON_XPATH}    timeout=10s
    Click Element    xpath=${THIRD_NEXT_BUTTON_XPATH}

Clic en Aprobar KCMS
    [Documentation]    Espera 4 segundos y luego hace clic en el botón de aprobar.
    Sleep    8s
    Wait Until Element Is Visible    xpath=${APPROVE_BUTTON_XPATH}    timeout=10s
    Click Element    xpath=${APPROVE_BUTTON_XPATH}

Mantener Ventana Abierta
    [Documentation]    Mantiene la ventana abierta durante 3 segundos para observación.
    Sleep    10s

Cerrar Navegador
    [Documentation]    Cierra el navegador después de completar las pruebas.
    Close Browser

*** Test Cases ***
Iniciar sesión, y aprobar payout
    [Documentation]    Flujo completo de login, navegación y confirmación de un payout.
    Abrir Página de Login
    Ingresar Credenciales    ${USER}    ${PASSWORD}
    Hacer Clic en Login
    Esperar a que Cargue el Home
    Hacer Clic en Pagos Masivos
    Esperar a que Cargue la Página
    Hacer Clic en Enlace de Pagos (Lista)
    Hacer Clic en Botón Importar
    Hacer Clic en Seleccione
    Seleccionar Opcion 2
    Cargar Archivo
    Hacer Clic en Próximo
    Hacer Clic en Botón Confirmar
    Hacer Clic en Botón Detalle de Pago
    Clic en Aprobar KCMS
    Mantener Ventana Abierta
    Cerrar Navegador
