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

Tentar Cadastrar Usuario Com Senha Vazia e Validar Erro
    [Documentation]    Tenta cadastrar um usuário com senha vazia.
    ${timestamp}=    Get Current Date    result_format=epoch
    ${payload}=      Create Dictionary
    ...              nome=Usuario Senha Vazia ${timestamp}
    ...              email=senha.vazia.${timestamp}@qa.com.br
    ...              password=${EMPTY}
    ...              administrador=true
    ${response}=    POST On Session    serverest    ${ENDPOINTS}[usuarios]    json=${payload}    expected_status=any
    Validar Status Code    ${response}    400
    Should Contain    ${response.text}    password

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

Teste de Listagem Usuarios
    [Documentation]    Valida listagem de usuários da API
    ${response}=    GET On Session    serverest    ${ENDPOINTS}[usuarios]    expected_status=any
    Validar Status Code    ${response}    200
    ${usuarios}=    Set Variable    ${response.json()}[usuarios]
    ${quantidade}=    Get Length    ${usuarios}
    Should Be True    ${quantidade} >= 0
    Log    API retornou ${quantidade} usuários

Teste de Email Muito Longo
    [Documentation]    Testa se API valida tamanho máximo de email
    ${timestamp}=    Get Current Date    result_format=epoch
    ${email_gigante}=    Evaluate    'a' * 200 + '@' + 'b' * 200 + '.com'
    ${payload}=      Create Dictionary
    ...              nome=Usuario Email Longo ${timestamp}
    ...              email=${email_gigante}
    ...              password=senha123
    ...              administrador=true
    ${response}=    POST On Session    serverest    ${ENDPOINTS}[usuarios]    json=${payload}    expected_status=any
    Should Be True    ${response.status_code} in [400, 422]
    Log    Email muito longo retornou: ${response.status_code}

Teste de Injecao SQL no Email
    [Documentation]    Testa se API é vulnerável a injeção SQL
    ${timestamp}=    Get Current Date    result_format=epoch
    ${payload}=      Create Dictionary
    ...              nome=Usuario SQL Injection
    ...              email=admin'; DROP TABLE usuarios; --@test.com
    ...              password=senha123
    ...              administrador=true
    ${response}=    POST On Session    serverest    ${ENDPOINTS}[usuarios]    json=${payload}    expected_status=any
    Should Be True    ${response.status_code} in [400, 422]
    Log    Injeção SQL retornou: ${response.status_code}

Teste de Rate Limiting
    [Documentation]    Testa se API tem limite de requisições por minuto
    FOR    ${i}    IN RANGE    50
        ${timestamp}=    Get Current Date    result_format=epoch
        ${payload}=      Create Dictionary
        ...              nome=Usuario Rate ${i} ${timestamp}
        ...              email=rate.${i}.${timestamp}@test.com
        ...              password=senha123
        ...              administrador=true
        ${response}=    POST On Session    serverest    ${ENDPOINTS}[usuarios]    json=${payload}    expected_status=any
        IF    ${response.status_code} == 429
            Log    Rate limiting ativado na requisição ${i}
            BREAK
        END
    END
