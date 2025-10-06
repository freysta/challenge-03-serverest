*** Keywords ***
Cadastrar Novo Usuario e Salvar ID
    [Documentation]    Cadastra um novo usuário e salva o ID e os dados para uso posterior.
    ${timestamp}=    Get Current Date    result_format=epoch
    ${payload}=      Create Dictionary
    ...              nome=Usuario Teste ${timestamp}
    ...              email=usuario.teste.${timestamp}@qa.com.br
    ...              password=senha123
    ...              administrador=true
    Set Suite Variable    ${DADOS_USUARIO}    ${payload}
    ${response}=    POST On Session    serverest    ${ENDPOINTS}[usuarios]    json=${payload}    expected_status=any
    Validar Status Code    ${response}    201
    Validar Mensagem    ${response}    ${MENSAGENS}[cadastro_sucesso]
    ${id_usuario}=    Extrair ID da Resposta    ${response.json()}
    Set Suite Variable    ${ID_USUARIO}    ${id_usuario}
    Sleep    2s



Deletar Usuario Criado
    [Documentation]    Exclui o usuário criado durante os testes.
    Log    ${ID_USUARIO}
    ${headers}=    Gerar Headers Com Token    ${TOKEN_AUTH}
    ${url}=    Catenate    SEPARATOR=/    ${ENDPOINTS}[usuarios]    ${ID_USUARIO}
    ${response}=    DELETE On Session    serverest    ${url}    headers=${headers}
    Validar Status Code    ${response}    200
    Validar Mensagem    ${response}    ${MENSAGENS}[exclusao_sucesso]

Tentar Cadastrar Usuario Duplicado e Validar Erro
    [Documentation]    Tenta cadastrar um usuário com um e-mail que já existe.
    ${response}=    POST On Session    serverest    ${ENDPOINTS}[usuarios]    json=${DADOS_USUARIO}    expected_status=any
    Validar Status Code    ${response}    400
    Validar Mensagem    ${response}    ${MENSAGENS}[email_duplicado]

Realizar Login e Salvar Token
    [Documentation]    Realiza login com o usuário criado e salva o token
    ${credenciais}=    Create Dictionary
    ...                email=${DADOS_USUARIO}[email]
    ...                password=${DADOS_USUARIO}[password]
    ${response}=       POST On Session    serverest    ${ENDPOINTS}[login]    json=${credenciais}    expected_status=any
    Validar Status Code    ${response}    200
    ${token}=          Obter Valor Do Campo    ${response}    authorization
    Set Suite Variable    ${TOKEN_AUTH}    ${token}

Tentar Cadastrar Usuario Com Senha Muito Curta e Validar Erro
    [Documentation]    Tenta cadastrar um usuário com senha de 3 caracteres.
    ${timestamp}=    Get Current Date    result_format=epoch
    ${payload}=      Create Dictionary
    ...              nome=Usuario Senha Muito Curta ${timestamp}
    ...              email=senha.muito.curta.${timestamp}@qa.com.br
    ...              password=123
    ...              administrador=true
    ${response}=    POST On Session    serverest    ${ENDPOINTS}[usuarios]    json=${payload}    expected_status=any
    Validar Status Code    ${response}    400
    Validar Mensagem    ${response}    password deve ter pelo menos 3 caracteres    password

Tentar Login Com Credenciais Invalidas
    [Documentation]    Tenta fazer login com credenciais inválidas
    ${credenciais}=    Create Dictionary
    ...                email=inexistente@qa.com.br
    ...                password=senhaerrada
    ${response}=       POST On Session    serverest    ${ENDPOINTS}[login]    json=${credenciais}    expected_status=any
    Validar Status Code    ${response}    401
    Validar Mensagem    ${response}    ${MENSAGENS}[login_invalido]

Teste de Idempotencia DELETE Usuario
    [Documentation]    Valida que DELETE é idempotente - pode ser executado várias vezes
    ${timestamp}=    Get Current Date    result_format=epoch
    ${payload}=      Create Dictionary
    ...              nome=Usuario Idempotencia ${timestamp}
    ...              email=idempotencia.${timestamp}@qa.com.br
    ...              password=senha123
    ...              administrador=true
    ${response}=    POST On Session    serverest    ${ENDPOINTS}[usuarios]    json=${payload}    expected_status=any
    Validar Status Code    ${response}    201
    ${id_usuario}=    Extrair ID da Resposta    ${response.json()}
    
    # Primeira exclusão - deve funcionar
    ${url}=    Catenate    SEPARATOR=/    ${ENDPOINTS}[usuarios]    ${id_usuario}
    ${response1}=    DELETE On Session    serverest    ${url}    expected_status=any
    Validar Status Code    ${response1}    200
    
    # Segunda exclusão - deve ser idempotente
    ${response2}=    DELETE On Session    serverest    ${url}    expected_status=any
    Should Be True    ${response2.status_code} in [200, 404]
    Log    Segunda exclusão retornou status: ${response2.status_code}

Teste de Paginacao Listar Usuarios
    [Documentation]    Valida paginação na listagem de usuários
    # Cria 3 usuários para garantir dados
    FOR    ${i}    IN RANGE    3
        ${timestamp}=    Get Current Date    result_format=epoch
        ${payload}=      Create Dictionary
        ...              nome=Usuario Paginacao ${i} ${timestamp}
        ...              email=paginacao.${i}.${timestamp}@qa.com.br
        ...              password=senha123
        ...              administrador=true
        POST On Session    serverest    ${ENDPOINTS}[usuarios]    json=${payload}    expected_status=any
    END
    
    # Testa paginação
    ${params}=    Create Dictionary    _page=1    _limit=2
    ${response}=    GET On Session    serverest    ${ENDPOINTS}[usuarios]    params=${params}    expected_status=any
    Validar Status Code    ${response}    200
    ${usuarios}=    Set Variable    ${response.json()}[usuarios]
    ${quantidade}=    Get Length    ${usuarios}
    Should Be True    ${quantidade} <= 2
    Log    Página 1 retornou ${quantidade} usuários
