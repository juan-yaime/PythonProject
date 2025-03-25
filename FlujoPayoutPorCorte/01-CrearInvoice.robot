*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    BuiltIn

*** Variables ***
${URL}    https://q2-api.kashio-dev.net/v2/payouts/invoices
${AUTHORIZATION}    Basic c2tfcTJfb1RtekJEWW40N1J4c2tYYVBGdGhHcTo=
${CUSTOMER_ID}    ext_1738076041
${NAME}    Juan Pablo
${PHONE}    +1738076035
${EMAIL}    kashio92@gmail.com
${DOCUMENT_TYPE}    CEX
${DOCUMENT_ID}    AA1738076041
${BANK_ID}    psp_w13k323ed23dmd00
${EXTERNAL_ID}    E-1738076035
${REQUEST_DATETIME}    2023-01-02 15:00
${CURRENCY}    PEN
${VALUE}    ${180}
${ORDER_ID}    order_id_1738076041
${ORDER_NAME}    order_name_1738076041
${ORDER_DESCRIPTION}    order_descripcion_1738076041
${NUM_RETRIES}    1

*** Keywords ***
Crear diccionario de datos del cliente

    ${bank}=    Create Dictionary    id=${BANK_ID}
    ${account}=    Create Dictionary    bank=${bank}    account_number=    type=SAVING    cci=80600432100901480286
    ${accounts}=    Create List    ${account}
    ${customer}=    Create Dictionary    external_id=${CUSTOMER_ID}    name=${NAME}    phone=${PHONE}    email=${EMAIL}    document_type=${DOCUMENT_TYPE}    document_id=${DOCUMENT_ID}    accounts=${accounts}
    [Return]    ${customer}

Post Request

    [Arguments]    ${url}    ${headers}    ${json_data}
    ${response}=    POST    ${url}    headers=${headers}    json=${json_data}
    [Return]    ${response}

Bucle for
    [Arguments]    ${url}    ${headers}    ${data}    ${num_retries}
    ${attempt}=    Set Variable    1
    ${last_response}=    Create Dictionary
    FOR    ${i}    IN RANGE    ${num_retries}
        Log    Intento ${attempt} de ${num_retries}: Enviando solicitud...
        ${response}=    Post Request    ${url}    ${headers}    ${data}
        Log    Intento ${attempt} - Respuesta: ${response.status_code}
        ${last_response}=    Set Variable    ${response}
        ${attempt}=    Evaluate    ${attempt} + 1
    END

    [Return]    ${last_response}

*** Test Cases ***
Crear Invoice

    ${customer}=    Crear diccionario de datos del cliente
    ${total}=    Create Dictionary    currency=${CURRENCY}    value=${VALUE}
    ${metadata}=    Create Dictionary    order_id=${ORDER_ID}    order_name=${ORDER_NAME}    order_description=${ORDER_DESCRIPTION}


    ${data}=    Create Dictionary    customer=${customer}    external_id=${EXTERNAL_ID}    request_datetime=${REQUEST_DATETIME}    total=${total}    metadata=${metadata}


    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=${AUTHORIZATION}

    # Enviar la solicitud POST varias veces


    ${response}=    Bucle for    ${URL}    ${headers}    ${data}    ${NUM_RETRIES}


    Should Be Equal As Numbers    ${response.status_code}    201
    Log    Respuesta final: ${response.text}

