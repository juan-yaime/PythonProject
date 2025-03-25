*** Settings ***
Library    DatabaseLibrary
Library    OperatingSystem
Library    Collections
Library    ExcelLibrary

# Configurar PYTHONPATH
Suite Setup    Set Environment Variable    PYTHONPATH    ${CURDIR}

*** Variables ***
${DB_HOST}      kashio-qa-02062023.cgq3qqvhlso3.us-east-1.rds.amazonaws.com
${DB_USER}      juan.yaime
${DB_PASSWORD}  QoqL9jB.nZ2c=<nFiwhL
${DB_NAME}      KashioCore
${DB_PORT}      3306
${XLS_FILE}     C:\\Users\\USUARIO\\Downloads\\PAYOUT 1050_TESORERIA.xls

*** Test Cases ***
Conectar a la base de datos y ejecutar consulta compleja
    # Conectar a la base de datos
    Connect To Database    pymysql    ${DB_NAME}    ${DB_USER}    ${DB_PASSWORD}    ${DB_HOST}    ${DB_PORT}

Ejecutar consulta SQL
    ${set_query}    Set Variable
    ...    SET @ProcessID = (SELECT process_id FROM Process WHERE public_id = 'pyo_q2_GnqkDTdUSGmWzCFLZYZJQS');

    ${select_query}    Set Variable
    ...    SELECT deb.document_number AS 'ID CLIENTE', CASE WHEN deb.document_type_id = 1 THEN 'DNI' WHEN deb.document_type_id = 3 THEN 'RUC' ELSE 'DNI' END AS 'DOCUMENTO', deb.document_number AS 'NUMERO DOCUMENTO', deb.name AS 'NOMBRE', 'email@pruebas.com' AS 'EMAIL', deb.phone_number AS 'TELEFONO', 'ACTIVO' AS 'ESTADO', inv.psp_tin AS 'ID ORDEN DE PAGO', inv.psp_tin AS 'REFERENCIA', inv.psp_tin AS 'NOMBRE ORDEN', inv.psp_tin AS 'DESCRIPCION', inv.currency_code AS 'MONEDA', ROUND(inv.amount, 2) AS 'MONTO', '31/12/2022' AS 'VENCIMIENTO', '31/12/2022' AS 'EXPIRACION', CASE WHEN bank.external_id = '001' THEN '1' WHEN bank.external_id = '002' THEN '2' WHEN bank.external_id = '003' THEN '3' WHEN bank.external_id = '004' THEN '4' ELSE '000' END AS 'CODIGO BANCO', acc.account_number AS 'CUENTA', CASE WHEN acc.metadata->>'$.type' = 'SAVING' THEN 'AHORRO' ELSE 'CORRIENTE' END AS 'TIPO DE CUENTA', acc.metadata->>'$.cci' AS 'CCI' FROM Customer cus JOIN Process proc ON proc.customer_id = cus.customer_id JOIN Payout_Process pyo ON pyo.payout_process_id = proc.process_id JOIN ProcessStatus proc_s2 ON proc_s2.process_status_id = proc.process_status_id AND proc_s2.process_type_id = 10 JOIN Payout_Process_Items ppi ON ppi.payout_process_id = pyo.payout_process_id JOIN Account acc_pyo ON acc_pyo.account_id = pyo.account_id JOIN Invoice inv ON ppi.resource_id = inv.invoice_id AND inv.create_date > '2023-04-01 15:45:15' JOIN Debtor deb ON deb.debtor_id = inv.debtor_id JOIN Customer deb_cus ON deb.customer_id = deb_cus.customer_id JOIN Account acc ON acc.customer_id = deb_cus.customer_id AND acc.public_id = CONVERT(inv.order_detail->>'$.metadata.accounts[0].id' USING utf8) JOIN Bank bank ON bank.bank_id = acc.bank_id JOIN ProcessStatus proc_s1 ON proc_s1.process_status_id = inv.status AND proc_s1.process_type_id = 1 LEFT JOIN Payout po ON ppi.payout_id = po.payout_id LEFT JOIN Transaction tr ON po.payout_id = tr.transaction_id LEFT JOIN Configuration cnf ON cnf.customer_id = cus.customer_id AND cnf.key = 'payouts_services.configuration' WHERE cus.customer_type_id = 104 AND pyo.payout_process_id = @ProcessID AND inv.status = 3;

    # Ejecutar la consulta
    Execute SQL String    ${set_query}

    ${result}    Query    ${select_query}
    Log    ${result}

    Run Keyword If    ${result}    Exportar a XLS    ${result}
    ...    ELSE    Log    No se encontraron registros para exportar.

*** Keywords ***
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

