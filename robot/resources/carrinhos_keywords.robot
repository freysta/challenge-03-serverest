*** Keywords ***
Criar Carrinho Com Produto e Salvar ID
    ${header}=     Create Dictionary    Authorization=${AUTH_TOKEN}
    ${produto}=    Create Dictionary    idProduto=${PRODUCT_ID}    quantidade=1
    ${produtos}=   Create List          ${produto}
    ${body}=       Create Dictionary    produtos=${produtos}

    ${response}=    POST On Session    serverest    /carrinhos    headers=${header}    json=${body}    expected_status=201
    Should Be Equal As Strings    ${response.json()}[message]    Cadastro realizado com sucesso
    Set Suite Variable    ${CART_ID}    ${response.json()}[_id]

Concluir Compra e Limpar ID
    ${header}=    Create Dictionary    Authorization=${AUTH_TOKEN}
    ${response}=    DELETE On Session    serverest    /carrinhos/concluir-compra    headers=${header}    expected_status=200
    Should Be Equal As Strings    ${response.json()}[message]    Registro excluído com sucesso
    Remove Suite Variable    ${CART_ID}
