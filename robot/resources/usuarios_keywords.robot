*** Settings ***
Library         String

*** Keywords ***
Cadastrar Novo Usuário e Salvar ID
    ${timestamp}=    Get Current Date    result_format=epoch
    ${body}=         Create Dictionary
    ...              nome=Gabriel Teste ${timestamp}
    ...              email=gabriel.teste.${timestamp}@qa.com.br
    ...              password=teste123
    ...              administrador=true
    Set Suite Variable    ${USER_PAYLOAD}    ${body}

    ${response}=    POST On Session    serverest    /usuarios    json=${body}    expected_status=201
    Should Be Equal As Strings    ${response.json()}[message]    Cadastro realizado com sucesso
    Set Suite Variable    ${USER_ID}    ${response.json()}[_id]

Realizar Login e Salvar Token
    ${credentials}=    Create Dictionary
    ...                email=${USER_PAYLOAD}[email]
    ...                password=${USER_PAYLOAD}[password]
    ${response}=      POST On Session    serverest    /login    json=${credentials}    expected_status=200
    ${token}=         Set Variable    ${response.json()}[authorization]
    Set Suite Variable    ${AUTH_TOKEN}    ${token}

Deletar Usuário Criado
    DELETE On Session    serverest    /usuarios/${USER_ID}    expected_status=200

Tentar Cadastrar Usuário Duplicado e Validar Erro
    ${response}=    POST On Session    serverest    /usuarios    json=${USER_PAYLOAD}    expected_status=400
    Should Be Equal As Strings    ${response.json()}[message]    Este email já está sendo usado
