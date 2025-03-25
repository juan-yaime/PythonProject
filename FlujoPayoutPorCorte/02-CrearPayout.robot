*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***
${URL}    https://q2-api.kashio-dev.net/kpayout/v1/payout_process
${ENDPOINT}    /api/acc_q2_4nk3zTWhRHHQewLuaQDpKi
${AUTHORIZATION}    Basic YXBpLXNlcnZpY2VzLWF1dGgta2V5OldPMjk2RjUwM0JBSTQwMFQ2MTRBRUw3NzBBOTM0VUpJNTA2RTE3MFo=

*** Keywords ***
Crear Payout
    [Arguments]    ${url}    ${headers}
    ${response}=    POST On Session    ${url}    ${headers}
    [Return]    ${response}

*** Test Cases ***
Crear Payout
    # Crear sesión con la URL base
    Create Session    mysession    ${URL}

    # Crear encabezados
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=${AUTHORIZATION}

    # Realizar la solicitud POST usando la sesión creada
    ${response}=    POST On Session    mysession    ${ENDPOINT}    headers=${headers}

    # Verificar el código de estado de la respuesta
    Should Be Equal As Numbers    ${response.status_code}    201
    Log    Respuesta: ${response.text}
