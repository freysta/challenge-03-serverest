*** Keywords ***
Realizar Login e Salvar Token
    [Documentation]    Realiza login com o usuário recém-criado e salva o token de autenticação.
    ${payload}=    Create Dictionary    email=${DADOS_USUARIO}[email]    password=${DADOS_USUARIO}[password]
    ${response}=    POST On Session    serverest    ${ENDPOINTS}[login]    json=${payload}
    Validar Status Code    ${response}    200
    Validar Mensagem    ${response}    ${MENSAGENS}[login_sucesso]
    ${token}=    Obter Valor Do Campo    ${response}    authorization
    Set Suite Variable    ${TOKEN_AUTH}    ${token}

Tentar Login Com Credenciais Invalidas
    [Documentation]    Tenta realizar login com credenciais inválidas.
    ${payload}=    Create Dictionary    email=email.invalido@qa.com.br    password=senha-invalida
    ${response}=    POST On Session    serverest    ${ENDPOINTS}[login]    json=${payload}
    Validar Status Code    ${response}    401
    Validar Mensagem    ${response}    ${MENSAGENS}[login_invalido]
