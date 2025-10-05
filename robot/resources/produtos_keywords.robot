*** Keywords ***
Cadastrar Novo Produto e Salvar ID
    ${timestamp}=       Get Current Date    result_format=epoch
    ${cabecalho}=       Create Dictionary    Authorization=${TOKEN_AUTH}
    ${dados_produto}=   Create Dictionary
    ...                 nome=Produto Teste ${timestamp}
    ...                 preco=150
    ...                 descricao=Produto para testes automatizados
    ...                 quantidade=100
    Set Suite Variable    ${DADOS_PRODUTO}    ${dados_produto}

    ${resposta}=    POST On Session    serverest    /produtos    headers=${cabecalho}    json=${dados_produto}    expected_status=201
    Should Be Equal As Strings    ${resposta.json()}[message]    Cadastro realizado com sucesso
    Set Suite Variable    ${ID_PRODUTO}    ${resposta.json()}[_id]

Deletar Produto Criado
    ${cabecalho}=    Create Dictionary    Authorization=${TOKEN_AUTH}
    DELETE On Session    serverest    /produtos/${ID_PRODUTO}    headers=${cabecalho}    expected_status=200

Tentar Excluir Produto Sem Token e Validar Erro
    DELETE On Session    serverest    /produtos/${ID_PRODUTO}    expected_status=401
    
Tentar Excluir Produto que Esta em um Carrinho
    ${cabecalho}=    Create Dictionary    Authorization=${TOKEN_AUTH}
    ${resposta}=     DELETE On Session    serverest    /produtos/${ID_PRODUTO}    headers=${cabecalho}    expected_status=400
    Should Be Equal As Strings    ${resposta.json()}[message]    Não é permitido excluir produto que faz parte de carrinho

Tentar Cadastrar Produto Com Preço Zero
    ${timestamp}=    Get Current Date    result_format=epoch
    ${header}=       Create Dictionary    Authorization=${AUTH_TOKEN}
    ${body}=         Create Dictionary
    ...              nome=Produto Preço Zero ${timestamp}
    ...              preco=0
    ...              descricao=Teste preço zero
    ...              quantidade=10
    ${response}=    POST On Session    serverest    /produtos    headers=${header}    json=${body}    expected_status=400
    Should Be Equal As Strings    ${response.json()}[preco]    preco deve ser um número positivo

Tentar Cadastrar Produto Com Preço Negativo
    ${timestamp}=    Get Current Date    result_format=epoch
    ${header}=       Create Dictionary    Authorization=${AUTH_TOKEN}
    ${body}=         Create Dictionary
    ...              nome=Produto Preço Negativo ${timestamp}
    ...              preco=-10
    ...              descricao=Teste preço negativo
    ...              quantidade=10
    ${response}=    POST On Session    serverest    /produtos    headers=${header}    json=${body}    expected_status=400
    Should Be Equal As Strings    ${response.json()}[preco]    preco deve ser um número positivo

Tentar Cadastrar Produto Com Quantidade Zero
    ${timestamp}=    Get Current Date    result_format=epoch
    ${header}=       Create Dictionary    Authorization=${AUTH_TOKEN}
    ${body}=         Create Dictionary
    ...              nome=Produto Qtd Zero ${timestamp}
    ...              preco=100
    ...              descricao=Teste quantidade zero
    ...              quantidade=0
    ${response}=    POST On Session    serverest    /produtos    headers=${header}    json=${body}    expected_status=400
    Should Be Equal As Strings    ${response.json()}[quantidade]    quantidade deve ser maior ou igual a 1

Tentar Cadastrar Produto Duplicado
    ${header}=       Create Dictionary    Authorization=${AUTH_TOKEN}
    ${response}=    POST On Session    serverest    /produtos    headers=${header}    json=${PRODUCT_PAYLOAD}    expected_status=400
    Should Be Equal As Strings    ${response.json()}[message]    Já existe produto com esse nome
