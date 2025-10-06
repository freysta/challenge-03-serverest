*** Keywords ***
Cadastrar Novo Produto e Salvar ID
    [Documentation]    Cadastra um novo produto e salva o ID para uso posterior.
    ${timestamp}=       Get Current Date    result_format=epoch
    ${payload}=         Create Dictionary
    ...                 nome=Produto Teste ${timestamp}
    ...                 preco=150
    ...                 descricao=Produto para testes automatizados
    ...                 quantidade=100
    Set Suite Variable    ${DADOS_PRODUTO}    ${payload}
    ${headers}=    Gerar Headers Com Token    ${TOKEN_AUTH}
    ${response}=    POST On Session    serverest    ${ENDPOINTS}[produtos]    headers=${headers}    json=${payload}    expected_status=any
    Validar Status Code    ${response}    201
    Validar Mensagem    ${response}    ${MENSAGENS}[cadastro_sucesso]
    ${id_produto}=    Extrair ID da Resposta    ${response.json()}
    Set Suite Variable    ${ID_PRODUTO}    ${id_produto}

Deletar Produto Criado
    [Documentation]    Exclui o produto criado durante os testes.
    ${headers}=    Gerar Headers Com Token    ${TOKEN_AUTH}
    ${url}=    Catenate    SEPARATOR=/    ${ENDPOINTS}[produtos]    ${ID_PRODUTO}
    ${response}=    DELETE On Session    serverest    ${url}    headers=${headers}    expected_status=any
    Validar Status Code    ${response}    200
    Validar Mensagem    ${response}    ${MENSAGENS}[exclusao_sucesso]

Tentar Excluir Produto Sem Token e Validar Erro
    [Documentation]    Tenta excluir um produto sem fornecer um token de autenticação.
    ${url}=    Catenate    SEPARATOR=/    ${ENDPOINTS}[produtos]    ${ID_PRODUTO}
    ${response}=    DELETE On Session    serverest    ${url}    expected_status=any
    Validar Status Code    ${response}    401
    Validar Mensagem    ${response}    ${MENSAGENS}[token_invalido]

Tentar Excluir Produto que Esta em um Carrinho
    [Documentation]    Tenta excluir um produto que está em um carrinho de compras.
    ${headers}=    Gerar Headers Com Token    ${TOKEN_AUTH}
    ${url}=    Catenate    SEPARATOR=/    ${ENDPOINTS}[produtos]    ${ID_PRODUTO}
    ${response}=    DELETE On Session    serverest    ${url}   headers=${headers}    expected_status=any
    Validar Status Code    ${response}    400
    Validar Mensagem    ${response}    ${MENSAGENS}[produto_em_carrinho]

Tentar Cadastrar Produto Com Preco Zero e Validar Erro
    [Documentation]    Tenta cadastrar um produto com preço zero.
    ${timestamp}=    Get Current Date    result_format=epoch
    ${payload}=      Create Dictionary
    ...              nome=Produto Preco Zero ${timestamp}
    ...              preco=0
    ...              descricao=Produto com preço zero
    ...              quantidade=10
    ${headers}=    Gerar Headers Com Token    ${TOKEN_AUTH}
    ${response}=    POST On Session    serverest    ${ENDPOINTS}[produtos]    headers=${headers}    json=${payload}    expected_status=any
    Validar Status Code    ${response}    400
    Validar Mensagem    ${response}    preco deve ser um número positivo    preco

Tentar Cadastrar Produto Com Preco Negativo e Validar Erro
    [Documentation]    Tenta cadastrar um produto com preço negativo.
    ${timestamp}=    Get Current Date    result_format=epoch
    ${payload}=      Create Dictionary
    ...              nome=Produto Negativo ${timestamp}
    ...              preco=-10
    ...              descricao=Produto com preço negativo
    ...              quantidade=10
    ${headers}=    Gerar Headers Com Token    ${TOKEN_AUTH}
    ${response}=    POST On Session    serverest    ${ENDPOINTS}[produtos]    headers=${headers}    json=${payload}    expected_status=any
    Validar Status Code    ${response}    400
    Validar Mensagem    ${response}    preco deve ser um número positivo    preco

Tentar Cadastrar Produto Com Quantidade Negativa e Validar Erro
    [Documentation]    Tenta cadastrar um produto com quantidade negativa.
    ${timestamp}=    Get Current Date    result_format=epoch
    ${payload}=      Create Dictionary
    ...              nome=Produto Qtd Negativa ${timestamp}
    ...              preco=100
    ...              descricao=Produto com quantidade negativa
    ...              quantidade=-1
    ${headers}=    Gerar Headers Com Token    ${TOKEN_AUTH}
    ${response}=    POST On Session    serverest    ${ENDPOINTS}[produtos]    headers=${headers}    json=${payload}    expected_status=any
    Validar Status Code    ${response}    400
    Validar Mensagem    ${response}    quantidade deve ser maior ou igual a 0    quantidade

Tentar Cadastrar Produto Duplicado e Validar Erro
    [Documentation]    Tenta cadastrar um produto com um nome que já existe.
    ${headers}=    Gerar Headers Com Token    ${TOKEN_AUTH}
    ${response}=    POST On Session    serverest    ${ENDPOINTS}[produtos]    headers=${headers}    json=${DADOS_PRODUTO}    expected_status=any
    Validar Status Code    ${response}    400
    Validar Mensagem    ${response}    ${MENSAGENS}[produto_duplicado]

Teste de Tipo de Dados Invalido Preco String
    [Documentation]    Valida que API rejeita preço como string
    ${timestamp}=    Get Current Date    result_format=epoch
    ${payload}=      Create Dictionary
    ...              nome=Produto Preco String ${timestamp}
    ...              preco=cem reais
    ...              descricao=Produto com preço inválido
    ...              quantidade=10
    ${headers}=    Gerar Headers Com Token    ${TOKEN_AUTH}
    ${response}=    POST On Session    serverest    ${ENDPOINTS}[produtos]    headers=${headers}    json=${payload}    expected_status=any
    Should Be True    ${response.status_code} in [400, 422]
    Log    API retornou status ${response.status_code} para preço inválido

Teste de Metodo HTTP Incorreto
    [Documentation]    Valida que API rejeita método HTTP inadequado
    ${url}=    Catenate    SEPARATOR=/    ${ENDPOINTS}[produtos]    ${ID_PRODUTO}
    ${response}=    POST On Session    serverest    ${url}    expected_status=any
    Should Be True    ${response.status_code} in [404, 405]
    Log    Método POST em rota de detalhe retornou: ${response.status_code}