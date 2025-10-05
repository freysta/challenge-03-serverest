*** Keywords ***
Criar Carrinho Com Produto e Salvar ID
    ${cabecalho}=      Create Dictionary    Authorization=${TOKEN_AUTH}
    ${item_produto}=   Create Dictionary    idProduto=${ID_PRODUTO}    quantidade=1
    ${lista_produtos}= Create List          ${item_produto}
    ${dados_carrinho}= Create Dictionary    produtos=${lista_produtos}

    ${resposta}=    POST On Session    serverest    /carrinhos    headers=${cabecalho}    json=${dados_carrinho}    expected_status=201
    Should Be Equal As Strings    ${resposta.json()}[message]    Cadastro realizado com sucesso
    Set Suite Variable    ${ID_CARRINHO}    ${resposta.json()}[_id]

Concluir Compra e Limpar ID
    ${cabecalho}=    Create Dictionary    Authorization=${TOKEN_AUTH}
    ${resposta}=     DELETE On Session    serverest    /carrinhos/concluir-compra    headers=${cabecalho}    expected_status=200
    Should Be Equal As Strings    ${resposta.json()}[message]    Registro excluído com sucesso
    Remove Suite Variable    ${ID_CARRINHO}

Cancelar Compra e Validar Restauracao de Estoque
    ${cabecalho}=    Create Dictionary    Authorization=${TOKEN_AUTH}
    ${resposta}=     DELETE On Session    serverest    /carrinhos/cancelar-compra    headers=${cabecalho}    expected_status=200
    Should Be Equal As Strings    ${resposta.json()}[message]    Registro excluído com sucesso. Estoque dos produtos reabastecido
    Remove Suite Variable    ${ID_CARRINHO}

Tentar Criar Carrinho Com Produto Inexistente
    ${header}=     Create Dictionary    Authorization=${AUTH_TOKEN}
    ${produto}=    Create Dictionary    idProduto=produto_inexistente_123    quantidade=1
    ${produtos}=   Create List          ${produto}
    ${body}=       Create Dictionary    produtos=${produtos}
    ${response}=    POST On Session    serverest    /carrinhos    headers=${header}    json=${body}    expected_status=400
    Should Be Equal As Strings    ${response.json()}[message]    Produto não encontrado

Tentar Criar Carrinho Com Quantidade Maior Que Estoque
    ${header}=     Create Dictionary    Authorization=${AUTH_TOKEN}
    ${produto}=    Create Dictionary    idProduto=${PRODUCT_ID}    quantidade=999
    ${produtos}=   Create List          ${produto}
    ${body}=       Create Dictionary    produtos=${produtos}
    ${response}=    POST On Session    serverest    /carrinhos    headers=${header}    json=${body}    expected_status=400
    Should Be Equal As Strings    ${response.json()}[message]    Produto não possui quantidade suficiente

Tentar Criar Segundo Carrinho Para Mesmo Usuário
    ${header}=     Create Dictionary    Authorization=${AUTH_TOKEN}
    ${produto}=    Create Dictionary    idProduto=${PRODUCT_ID}    quantidade=1
    ${produtos}=   Create List          ${produto}
    ${body}=       Create Dictionary    produtos=${produtos}
    ${response}=    POST On Session    serverest    /carrinhos    headers=${header}    json=${body}    expected_status=400
    Should Be Equal As Strings    ${response.json()}[message]    Não é permitido ter mais de 1 carrinho
