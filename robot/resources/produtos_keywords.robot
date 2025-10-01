*** Keywords ***
Cadastrar Novo Produto e Salvar ID
    ${timestamp}=    Get Current Date    result_format=epoch
    ${header}=       Create Dictionary    Authorization=${AUTH_TOKEN}
    ${body}=         Create Dictionary
    ...              nome=Produto Teste ${timestamp}
    ...              preco=150
    ...              descricao=Produto de teste
    ...              quantidade=100
    Set Suite Variable    ${PRODUCT_PAYLOAD}    ${body}

    ${response}=    POST On Session    serverest    /produtos    headers=${header}    json=${body}    expected_status=201
    Should Be Equal As Strings    ${response.json()}[message]    Cadastro realizado com sucesso
    Set Suite Variable    ${PRODUCT_ID}    ${response.json()}[_id]

Deletar Produto Criado
    ${header}=    Create Dictionary    Authorization=${AUTH_TOKEN}
    DELETE On Session    serverest    /produtos/${PRODUCT_ID}    headers=${header}    expected_status=200

Tentar Excluir Produto Sem Token e Validar Erro
    DELETE On Session    serverest    /produtos/${PRODUCT_ID}    expected_status=401
    
Tentar Excluir Produto que Está em um Carrinho
    ${header}=    Create Dictionary    Authorization=${AUTH_TOKEN}
    ${response}=    DELETE On Session    serverest    /produtos/${PRODUCT_ID}    headers=${header}    expected_status=400
    Should Be Equal As Strings    ${response.json()}[message]    Não é permitido excluir produto que faz parte de carrinho
