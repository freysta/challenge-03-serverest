*** Settings ***
Library    Collections
Library    ../fixtures/payloads.py

*** Keywords ***
Validar Status Code
    [Documentation]    Valida se o status code da resposta está correto
    [Arguments]    ${response}    ${expected_status}
    Should Be Equal As Numbers    ${response.status_code}    ${expected_status}

Validar Mensagem
    [Documentation]    Valida mensagem específica na resposta
    [Arguments]    ${response}    ${expected_message}    ${field}=message
    Should Be Equal As Strings    ${response.json()}[${field}]    ${expected_message}

Gerar Headers Com Token
    [Documentation]    Gera headers com token de autorização
    [Arguments]    ${token}
    ${headers}=    Create Dictionary    Authorization=${token}
    RETURN    ${headers}

Extrair ID da Resposta
    [Documentation]    Extrai o ID de uma resposta JSON
    [Arguments]    ${response_json}
    RETURN    ${response_json}[_id]

Gerar Usuario
    [Documentation]    Gera dados válidos para usuário
    ${payload}=    Gerar Usuario Valido
    RETURN    ${payload}

Gerar Produto
    [Documentation]    Gera dados válidos para produto
    ${payload}=    Gerar Produto Valido
    RETURN    ${payload}

Gerar Produto Preco Negativo
    [Documentation]    Gera produto com preço negativo
    ${payload}=    Gerar Produto Preco Negativo
    RETURN    ${payload}

Gerar Carrinho
    [Documentation]    Gera dados válidos para carrinho
    [Arguments]    ${id_produto}
    ${payload}=    Gerar Carrinho Valido    ${id_produto}
    RETURN    ${payload}

Gerar Usuario Senha Curta
    [Documentation]    Gera usuário com senha de 4 caracteres
    ${payload}=    Gerar Usuario Senha Curta
    RETURN    ${payload}