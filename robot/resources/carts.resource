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