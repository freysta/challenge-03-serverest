*** Settings ***
Library         String
Library         DateTime

*** Keywords ***
Cadastrar Novo Usuario e Salvar ID
    ${timestamp}=    Get Current Date    result_format=epoch
    ${dados_usuario}=    Create Dictionary
    ...                  nome=Usuario Teste ${timestamp}
    ...                  email=usuario.teste.${timestamp}@qa.com.br
    ...                  password=senha123
    ...                  administrador=true
    Set Suite Variable    ${DADOS_USUARIO}    ${dados_usuario}

    ${resposta}=    POST On Session    serverest    /usuarios    json=${dados_usuario}    expected_status=201
    Should Be Equal As Strings    ${resposta.json()}[message]    Cadastro realizado com sucesso
    Set Suite Variable    ${ID_USUARIO}    ${resposta.json()}[_id]

Realizar Login e Salvar Token
    ${credenciais}=    Create Dictionary
    ...                email=${DADOS_USUARIO}[email]
    ...                password=${DADOS_USUARIO}[password]
    ${resposta}=       POST On Session    serverest    /login    json=${credenciais}    expected_status=200
    ${token}=          Set Variable    ${resposta.json()}[authorization]
    Set Suite Variable    ${TOKEN_AUTH}    ${token}

Deletar Usuario Criado
    DELETE On Session    serverest    /usuarios/${ID_USUARIO}    expected_status=200

Tentar Cadastrar Usuario Duplicado e Validar Erro
    ${resposta}=    POST On Session    serverest    /usuarios    json=${DADOS_USUARIO}    expected_status=400
    Should Be Equal As Strings    ${resposta.json()}[message]    Este email já está sendo usado

Tentar Cadastrar Usuario Com Senha de 4 Caracteres
    ${timestamp}=    Get Current Date    result_format=epoch
    ${dados_teste}=  Create Dictionary
    ...              nome=Teste Senha 4 Chars
    ...              email=senha4.${timestamp}@qa.com.br
    ...              password=1234
    ...              administrador=true
    ${resposta}=     POST On Session    serverest    /usuarios    json=${dados_teste}    expected_status=400
    Should Be Equal As Strings    ${resposta.json()}[password]    password deve ter pelo menos 5 caracteres

Tentar Cadastrar Usuario Com Senha de 5 Caracteres
    ${timestamp}=    Get Current Date    result_format=epoch
    ${body}=         Create Dictionary
    ...              nome=Teste Senha 5
    ...              email=senha5.${timestamp}@qa.com.br
    ...              password=12345
    ...              administrador=true
    ${response}=    POST On Session    serverest    /usuarios    json=${body}    expected_status=201
    Should Be Equal As Strings    ${response.json()}[message]    Cadastro realizado com sucesso
    DELETE On Session    serverest    /usuarios/${response.json()}[_id]    expected_status=200

Tentar Cadastrar Usuario Com Senha de 10 Caracteres
    ${timestamp}=    Get Current Date    result_format=epoch
    ${body}=         Create Dictionary
    ...              nome=Teste Senha 10
    ...              email=senha10.${timestamp}@qa.com.br
    ...              password=1234567890
    ...              administrador=true
    ${response}=    POST On Session    serverest    /usuarios    json=${body}    expected_status=201
    Should Be Equal As Strings    ${response.json()}[message]    Cadastro realizado com sucesso
    DELETE On Session    serverest    /usuarios/${response.json()}[_id]    expected_status=200

Tentar Login Com Credenciais Invalidas
    ${credentials}=    Create Dictionary
    ...                email=inexistente@qa.com.br
    ...                password=senhaerrada
    ${response}=      POST On Session    serverest    /login    json=${credentials}    expected_status=401
    Should Be Equal As Strings    ${response.json()}[message]    Email e/ou senha inválidos
