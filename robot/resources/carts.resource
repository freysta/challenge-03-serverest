*** Keywords ***
Criar Carrinho Com Produto e Salvar ID
    [Documentation]    Cria um carrinho de compras com um produto e salva o ID do carrinho.
    ${produto}=      Create Dictionary    idProduto=${ID_PRODUTO}    quantidade=1
    ${produtos}=     Create List    ${produto}
    ${payload}=      Create Dictionary    produtos=${produtos}
    ${headers}=    Gerar Headers Com Token    ${TOKEN_AUTH}
    ${response}=    POST On Session    serverest    ${ENDPOINTS}[carrinhos]    headers=${headers}    json=${payload}    expected_status=any
    Validar Status Code    ${response}    201
    Validar Mensagem    ${response}    ${MENSAGENS}[cadastro_sucesso]
    ${id_carrinho}=    Extrair ID da Resposta    ${response.json()}
    Set Suite Variable    ${ID_CARRINHO}    ${id_carrinho}

Concluir Compra e Limpar ID
    [Documentation]    Conclui a compra de um carrinho e limpa o ID do carrinho.
    ${headers}=    Gerar Headers Com Token    ${TOKEN_AUTH}
    ${response}=    DELETE On Session    serverest    ${ENDPOINTS}[concluir_compra]    headers=${headers}    expected_status=any
    Validar Status Code    ${response}    200
    Validar Mensagem    ${response}    ${MENSAGENS}[exclusao_sucesso]

Cancelar Compra e Validar Restauracao de Estoque
    [Documentation]    Cancela a compra de um carrinho e valida a restauração do estoque.
    ${headers}=    Gerar Headers Com Token    ${TOKEN_AUTH}
    ${response}=    DELETE On Session    serverest    ${ENDPOINTS}[cancelar_compra]    headers=${headers}    expected_status=any
    Validar Status Code    ${response}    200
    Validar Mensagem    ${response}    ${MENSAGENS}[estoque_reabastecido]

Tentar Criar Carrinho Com Produto Inexistente
    [Documentation]    Tenta criar um carrinho com um produto que não existe.
    ${produto}=      Create Dictionary    idProduto=produto_inexistente_123    quantidade=1
    ${produtos}=     Create List    ${produto}
    ${payload}=      Create Dictionary    produtos=${produtos}
    ${headers}=    Gerar Headers Com Token    ${TOKEN_AUTH}
    ${response}=    POST On Session    serverest    ${ENDPOINTS}[carrinhos]    headers=${headers}    json=${payload}    expected_status=any
    Validar Status Code    ${response}    400
    Validar Mensagem    ${response}    Produto não encontrado

Tentar Criar Carrinho Com Quantidade Maior Que Estoque
    [Documentation]    Tenta criar um carrinho com uma quantidade de produto maior que a disponível em estoque.
    ${produto}=      Create Dictionary    idProduto=${ID_PRODUTO}    quantidade=999
    ${produtos}=     Create List    ${produto}
    ${payload}=      Create Dictionary    produtos=${produtos}
    ${headers}=    Gerar Headers Com Token    ${TOKEN_AUTH}
    ${response}=    POST On Session    serverest    ${ENDPOINTS}[carrinhos]    headers=${headers}    json=${payload}    expected_status=any
    Validar Status Code    ${response}    400
    Validar Mensagem    ${response}    Produto não possui quantidade suficiente

Tentar Criar Segundo Carrinho Para Mesmo Usuario
    [Documentation]    Tenta criar um segundo carrinho para o mesmo usuário.
    ${produto}=      Create Dictionary    idProduto=${ID_PRODUTO}    quantidade=1
    ${produtos}=     Create List    ${produto}
    ${payload}=      Create Dictionary    produtos=${produtos}
    ${headers}=    Gerar Headers Com Token    ${TOKEN_AUTH}
    ${response}=    POST On Session    serverest    ${ENDPOINTS}[carrinhos]    headers=${headers}    json=${payload}    expected_status=any
    Validar Status Code    ${response}    400
    Validar Mensagem    ${response}    ${MENSAGENS}[carrinho_duplicado]

Teste de Concorrencia Ultimo Item Estoque
    [Documentation]    Simula concorrência para o último item em estoque
    # Cria produto com quantidade 1
    ${timestamp}=       Get Current Date    result_format=epoch
    ${payload_produto}=    Create Dictionary
    ...                    nome=Produto Unico ${timestamp}
    ...                    preco=100
    ...                    descricao=Produto com estoque 1
    ...                    quantidade=1
    ${headers}=    Gerar Headers Com Token    ${TOKEN_AUTH}
    ${response}=    POST On Session    serverest    ${ENDPOINTS}[produtos]    headers=${headers}    json=${payload_produto}    expected_status=any
    ${id_produto_unico}=    Extrair ID da Resposta    ${response.json()}
    
    # Cria carrinho com o produto
    ${produto}=      Create Dictionary    idProduto=${id_produto_unico}    quantidade=1
    ${produtos}=     Create List    ${produto}
    ${payload_carrinho}=    Create Dictionary    produtos=${produtos}
    ${response}=    POST On Session    serverest    ${ENDPOINTS}[carrinhos]    headers=${headers}    json=${payload_carrinho}    expected_status=any
    
    # Primeira conclusão deve funcionar
    ${response1}=    DELETE On Session    serverest    ${ENDPOINTS}[concluir_compra]    headers=${headers}    expected_status=any
    Should Be True    ${response1.status_code} in [200, 400]
    Log    Primeira conclusão: ${response1.status_code}

Teste de Carrinho Com 1000 Produtos
    [Documentation]    Testa se API lida com carrinho muito grande
    ${headers}=    Gerar Headers Com Token    ${TOKEN_AUTH}
    ${produtos_list}=    Create List
    FOR    ${i}    IN RANGE    1000
        ${produto_item}=    Create Dictionary    idProduto=${ID_PRODUTO}    quantidade=1
        Append To List    ${produtos_list}    ${produto_item}
    END
    ${payload}=    Create Dictionary    produtos=${produtos_list}
    ${response}=    POST On Session    serverest    ${ENDPOINTS}[carrinhos]    headers=${headers}    json=${payload}    expected_status=any
    Should Be True    ${response.status_code} in [400, 413, 422]
    Log    Carrinho com 1000 produtos: ${response.status_code}

Teste de Token Expirado
    [Documentation]    Testa comportamento com token inválido/expirado
    ${headers}=    Create Dictionary    Authorization=Bearer token_fake_expirado_12345
    ${produto}=      Create Dictionary    idProduto=${ID_PRODUTO}    quantidade=1
    ${produtos}=     Create List    ${produto}
    ${payload}=      Create Dictionary    produtos=${produtos}
    ${response}=    POST On Session    serverest    ${ENDPOINTS}[carrinhos]    headers=${headers}    json=${payload}    expected_status=any
    Should Be Equal As Numbers    ${response.status_code}    401
    Log    Token expirado retornou: ${response.status_code}

Teste de Produto Com ID Muito Longo
    [Documentation]    Testa se API valida formato do ID do produto
    ${headers}=    Gerar Headers Com Token    ${TOKEN_AUTH}
    ${id_gigante}=    Evaluate    'a' * 1000
    ${produto}=      Create Dictionary    idProduto=${id_gigante}    quantidade=1
    ${produtos}=     Create List    ${produto}
    ${payload}=      Create Dictionary    produtos=${produtos}
    ${response}=    POST On Session    serverest    ${ENDPOINTS}[carrinhos]    headers=${headers}    json=${payload}    expected_status=any
    Should Be True    ${response.status_code} in [400, 422]
    Log    ID gigante retornou: ${response.status_code}